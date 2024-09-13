import 'dart:convert';
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:path/path.dart';
import 'package:klontong_project/core/data/exception.dart';

class ApiBaseHelper {
  final InterceptedClient client;
  final Alice? networkInspector;

  ApiBaseHelper({required this.client, this.networkInspector});

  Future<dynamic> getPublicApi(String url,
      {Map<String, String>? qParams}) async {
    return getRestrictApi('', url, qParams: qParams);
  }

  Future<dynamic> getRestrictApi(String accessToken, String url,
      {Map<String, String>? qParams}) async {
    var headers = await generateHeaders(accessToken);
    return getWithCustomHeaders(url, headers: headers, qParams: qParams);
  }

  Future<dynamic> getWithCustomHeaders(String url,
      {Map<String, String>? headers, Map<String, String>? qParams}) async {
    final dynamic responseJson;
    try {
      final response = await client.get(
          Uri.parse(url).replace(queryParameters: qParams),
          headers: headers);
      if (kDebugMode) networkInspector?.onHttpResponse(response);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> postRestrictApi(
    String url,
    String accessToken, {
    Map<String, dynamic>? body,
  }) async {
    var headers = await generateHeaders(accessToken);
    return postWithCustomHeaders(url, headers: headers, body: body);
  }

  Future<dynamic> updateRestrictApi(
    String url,
    String accessToken, {
    Map<String, dynamic>? body,
  }) async {
    var headers = await generateHeaders(accessToken);
    return updateWithCustomHeaders(url, headers: headers, body: body);
  }

  Future<dynamic> deleteRestrictApi(
    String url,
    String accessToken, {
    Map<String, dynamic>? body,
  }) async {
    var headers = await generateHeaders(accessToken);
    return deleteWithCustomHeaders(url, headers: headers, body: body);
  }

  Future<dynamic> postPublicApi(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return postRestrictApi(url, '', body: body);
  }

  Future<dynamic> updatePublicApi(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return updateRestrictApi(url, '', body: body);
  }

  Future<dynamic> deletePublicApi(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return deleteRestrictApi(url, '', body: body);
  }

  Future<dynamic> postWithCustomHeaders(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final dynamic responseJson;
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      if (kDebugMode) networkInspector?.onHttpResponse(response);
      debugPrint('POST body: ${jsonEncode(body)}');
      debugPrint('response: ${jsonDecode(response.body.toString())}');
      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> updateWithCustomHeaders(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final dynamic responseJson;
    try {
      final response = await client.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      if (kDebugMode) networkInspector?.onHttpResponse(response);
      debugPrint(
          'response code: ${jsonDecode(response.statusCode.toString())}');
      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> deleteWithCustomHeaders(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final dynamic responseJson;
    try {
      final response = await client.delete(Uri.parse(url), headers: headers);
      if (kDebugMode) networkInspector?.onHttpResponse(response);
      debugPrint(
          'response code: ${jsonDecode(response.statusCode.toString())}');
      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> upload(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? body,
    required Map<String, File> files,
  }) async {
    final dynamic responseJson;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      if (headers != null) {
        request.headers.addAll(headers);
      } else {
        var headers = await generateHeaders('');
        if (headers != null) request.headers.addAll(headers);
      }
      if (body != null) {
        request.fields.addAll(body);
      }

      await Future.forEach(files.keys, (String key) async {
        final value = files[key];
        if (value != null) {
          final stream = http.ByteStream(value.openRead());
          stream.cast();
          final length = await value.length();
          final multipartFile = http.MultipartFile(key, stream, length,
              filename: basename(value.path));
          request.files.add(multipartFile);
        }
      });

      final response = await request.send();
      final responseFromStream = await http.Response.fromStream(response);
      if (kDebugMode) {
        networkInspector?.onHttpResponse(responseFromStream, body: body);
      }
      debugPrint('file: ${jsonEncode(request.files.toString())}');
      debugPrint('POST body: ${jsonEncode(body)}');
      responseJson = _returnResponse(responseFromStream);
    } on SocketException {
      throw NoConnectionException();
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        if (response.body.isEmpty) return {};
        var responseJson = json.decode(response.body.toString());
        if (kDebugMode) {
          print(responseJson);
        }
        return responseJson;
      case HttpStatus.created:
        var responseJson = json.decode(response.body.toString());
        if (kDebugMode) {
          print(responseJson);
        }
        return responseJson;
      case HttpStatus.badRequest:
        throw BadRequestException(response.body.toString(),'');
      case HttpStatus.notFound:
        if (kDebugMode) {
          print(response.body.toString());
        }
        if (response.body.isNotEmpty) {
          var responses = json.decode(response.body.toString());
          var getMessage = responses['message'];
          throw BadRequestException(getMessage, '');
        }
        throw BadRequestException(response.body.toString(), '');
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        throw UnauthorisedException(response.body.toString());
      case HttpStatus.internalServerError:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating to server with statusCode : ${response.statusCode}');
    }
  }

  /// GENERATE HEADERS

  Future<Map<String, String>?> generateHeaders(String? accessToken) async {
    final token = accessToken ?? '';
    var headers = <String, String>{
      'content-type': 'application/json',
      'x-access-token': 'Bearer $token',
      'timestamp': getUnixTimeStamp(),
      'platform': 'mobile-apps'
    };
    if (!kReleaseMode) {
      var debugHeaders = <String, String>{'x-debug': "true"};
      headers.addAll(debugHeaders);
    }

    return headers;
  }

  String getUnixTimeStamp() {
    return '${DateTime.now().millisecondsSinceEpoch}';
  }
}
