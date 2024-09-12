class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error during communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message, prefix]) : super(message, "Invalid request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class ServerErrorException extends AppException {
  ServerErrorException([String? message])
      : super(message, "Server returns error: ");
}

class ParseDataException extends AppException {
  ParseDataException([message])
      : super(message, "Failed to parse data from the response: ");
}

class NoConnectionException extends AppException {
  NoConnectionException() : super("No Internet connection.");
}

class DataNotFoundException extends AppException {
  DataNotFoundException() : super("No data found.");
}

class FormatException extends AppException {
  FormatException() : super("Error parsing format response from server.");
}
