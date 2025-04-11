class AuthException implements Exception {
  String code;
  String title;
  String message;

  AuthException({this.code = 'no_code', this.title = 'no_title', this.message = 'no_message'});

  @override
  String toString() => title;
}

/// Launched when authorization URL cannot be generated.
class UrlException extends AuthException {
  UrlException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Server returned a non-200 status code';
    } else if (code == 'E002') {
      title = 'URL is null, or not found in server response';
    }
  }
}

/// Launched when there is a problem with the environment variables.
class EnvException extends AuthException {
  EnvException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Environment variables not found';
    } else if (code == 'E002') {
      title = 'Missing or empty env variable';
    }
  }
}

/// Launched when the authorization code is not found in the response URL.
class NoCodeException extends AuthException {
  NoCodeException({super.code, super.message}) {
    title = 'Authorization code not found in response URL';
    }
}

/// Launched when the request to exchange the code for a token fails.
class TokenExchangeException extends AuthException {
  TokenExchangeException({super.code, super.message}) {
    title = 'Failed to exchange authorization code for token';
  }
}

/// Launched when the request to refresh the token fails.
class LoginException extends AuthException {
  LoginException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Cannot identify user in the database';
    }
  }
}

/// Launched when the request to register a user fails.
class RegisterException extends AuthException {
  RegisterException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Cannot register user';
    }
  }
}

/// Launched when the request to add a profile fails.
class DatabaseException extends AuthException {
  DatabaseException({super.code, super.message}) {
    if (code == 'E001') {
      title = 'Database error adding a new profile';
    } else if (code == 'E002') {
      title = 'User data not found in the database';
    } else if (code == 'E003') {
      title = 'User not found in the database';
    } else if (code == 'E004') {
      title = 'User not found in the database';
    }
  }
}
