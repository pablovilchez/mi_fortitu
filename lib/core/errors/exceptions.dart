import 'package:easy_localization/easy_localization.dart';

abstract class CoreAuthException implements Exception {
  final String message;
  CoreAuthException([String? message])
      : message = message ?? tr('errors.default_message');

  @override
  String toString() => message;
}

/// Launched when there is an error refreshing a token.
class RefreshTokenException extends CoreAuthException {
  RefreshTokenException([String? message])
      : super(message ?? tr('errors.refresh_token_exception'));
}

/// Launched when there is a problem getting token information.
class TokenInfoException extends CoreAuthException {
  TokenInfoException([String? message])
      : super(message ?? tr('errors.token_info_exception'));
}

/// Launched when there is a problem saving the tokens.
class SaveTokenException extends CoreAuthException {
  SaveTokenException([String? message])
      : super(message ?? tr('errors.save_token_exception'));
}