import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    print('----- Request -----');
    print(request.toString());
    print(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    print('----- Response -----');
    print('Code: ${response.statusCode}');
    if (response is Response) {
      print((response).body);
    }
    if (response.statusCode == 401 || response.statusCode >= 500) {
      // do something
    }
    return response;
  }
}
