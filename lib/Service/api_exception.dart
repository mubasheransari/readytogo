class ApiException implements Exception {
  final _message;
  final _prefix;
  ApiException([this._message, this._prefix]);
  @override
  String toString() => "$_prefix$_message";
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InternalServerException extends ApiException {
  InternalServerException([String? message])
      : super(message, "Internal Server Error: ");
}
