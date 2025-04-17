class AuthException implements Exception {
  String code;
  String title;
  String message;

  AuthException({this.code = 'no_code', this.title = 'no_title', this.message = 'no_message'}) {
    print(
      '*** DEBUG *** AuthException:\n'
      '  Type: $runtimeType\n'
      '  Code: $code\n'
      '  Title: $title\n'
      '  Message: $message',
    );
  }

  @override
  String toString() => title;
}

class DbLoginException extends AuthException {
  DbLoginException({super.code, super.message}) {
    title = 'Invalid login credentials';
  }
}

class DbRegisterException extends AuthException {
  DbRegisterException({super.code, super.message}) {
    title = 'Cannot register user';
  }
}

class DbCheckException extends AuthException {
  DbCheckException({super.code, super.message}) {
    if (code == '01') {
      title = 'User not found in the database (null)';
    } else if (code == '02') {
      title = 'User not found in the database (error)';
    }
  }
}

class DbDataException extends AuthException {
  DbDataException({super.code, super.message}) {
    if (code == '01') {
      title = 'Role/Profile not found in the database';
    } else if (code == '02') {
      title = 'Failed to add profile to the database';
    }
  }
}

class OAuthException extends AuthException {
  OAuthException({super.code, super.message}) {
    if (code == '01') {
      title = 'Cannot get authorization URL. Bad request';
    } else if (code == '02') {
      title = 'URL is null, or not found in server response';
    } else if (code == '03') {
      title = 'Failed to listening for redirect URL';
    } else if (code == '04') {
      title = 'Authorization code not found in response URL';
    } else if (code == '05') {
      title = 'Failed to exchange authorization code for token. Bad request';
    }
  }
}
