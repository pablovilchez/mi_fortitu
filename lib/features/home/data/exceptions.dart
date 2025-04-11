class RequestException implements Exception {
  String code;
  String title;
  String message;

  RequestException({this.code = 'no_code', this.title = 'no_title', this.message = 'no_message'});

  @override
  String toString() => title;
}

class TokenException extends RequestException {
  TokenException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Cannot get a valid token';
    }
  }
}

class CodeException extends RequestException {
  CodeException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'API returned a non-200 code';
    }
  }
}

class DataException extends RequestException {
  DataException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Failed receiving or parsing request data';
    } else if (code == 'E002') {
      title = 'Failed parsing profile data';
    } else if (code == 'E003') {
      title = 'Failed parsing user events data';
    } else if (code == 'E004') {
      title = 'Failed parsing campus events data';
    } else if (code == 'E005') {
      title = 'Failed parsing cluster user data';
    }
  }
}