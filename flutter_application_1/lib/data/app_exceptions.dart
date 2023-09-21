class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return _message + "  " + _prefix;
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException(String? message)
      : super(message, "Error During Communication");
}

class BadRequestException extends AppExceptions {
  BadRequestException(String? message) : super(message, "Invalid Request");
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException(String? message)
      : super(message, "Unauthorized Request");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException(String? message)
      : super(message, "Invalid Input Request");
}
