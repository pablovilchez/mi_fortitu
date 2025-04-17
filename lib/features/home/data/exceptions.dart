class HomeException implements Exception {
  String code;
  String title;
  String message;

  HomeException({this.code = 'no_code', this.title = 'no_title', this.message = 'no_message'}) {
    print(
      '*** DEBUG *** HomeException:\n'
          '  Type: $runtimeType\n'
          '  Code: $code\n'
          '  Title: $title\n'
          '  Message: $message',
    );
  }

  @override
  String toString() => title;
}

class AuthException extends HomeException {
  AuthException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Cannot get a valid token';
    }
  }
}

class RequestException extends HomeException {
  RequestException({super.code, super.message}) {
    if (code == '01') {
      title = 'Bad request';
    } else if (code == '02') {
      title = 'Failed to get a valid response. Unexpected response';
    }
  }
}

class DataException extends HomeException {
  DataException({super.code, super.message}) {
    title = 'Failed parsing request data';
  }
}