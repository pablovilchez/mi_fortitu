import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/config/env_config.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
import 'package:mi_fortitu/features/auth/data/exceptions.dart';

/// A data source for handling Intra authentication.
///
/// This class is responsible for managing the authentication process with Intra,
/// including obtaining the authorization URL, handling redirects,
/// and exchanging authorization codes for access tokens.
class AuthIntraDatasource {
  final http.Client httpClient;
  final AppLinks appLinks;
  final UrlLauncherService launcher;
  final EnvConfig env;

  AuthIntraDatasource(this.httpClient, this.appLinks, this.launcher, this.env,);

  /// Handles the authentication process with Intra.
  ///
  /// This method first retrieves the authorization URL, then launches it in the browser.
  /// After the user authorizes the app, it listens for the redirect URI to extract the
  /// authorization code. Finally, it exchanges the authorization code for an access token.
  Future<Either<AuthException, Map<String, dynamic>>> requestNewTokens() async {
    // Check if the environment variables are set.
    final redirectUri = env.redirectUri;
    final codeForTokenFunctionUrl = env.codeForTokenFunctionUrl;

    // Get the authorization URL from the server and launch it in the browser.
    final responseAuthUrl = await _getAuthorizationUrl();
    if (responseAuthUrl.isLeft()) {
      return Left(responseAuthUrl.fold((failure) => failure, (r) => AuthException()));
    }
    final authUrl = responseAuthUrl.getOrElse(() => '');
    await launcher.redirect(Uri.parse(authUrl));

    // Listen for the redirect URI.
    final responseRedirectUrl = await _listenForRedirect(Uri.parse(redirectUri));
    if (responseRedirectUrl.isLeft()) {
      return Left(responseRedirectUrl.fold((failure) => failure, (r) => AuthException()));
    }
    final responseUrl = responseRedirectUrl.getOrElse(() => Uri.parse(''));

    // Extract the authorization code and change it for an access token.
    final code = responseUrl.queryParameters['code'];
    if (code == null) {
      return Left(OAuthException(code: '04'));
    }
    final response = await httpClient.post(
      Uri.parse(codeForTokenFunctionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}),
    );
    if (response.statusCode != 200) {
      return Left(OAuthException(code: '04', message: '${response.statusCode}: ${response.body}'));
    }

    return Right(jsonDecode(response.body));
  }

  /// Gets the authorization URL for Intra authentication.
  Future<Either<AuthException, String>> _getAuthorizationUrl() async {
    final getAuthUrlFunctionUrl = env.getAuthUrlFunctionUrl;
    final tokenScope = env.intraTokenScope;

    final response = await httpClient.post(
      Uri.parse(getAuthUrlFunctionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'scope': tokenScope}),
    );

    if (response.statusCode != 200) {
      return Left(OAuthException(code: '01', message: '${response.statusCode}: ${response.body}'));
    }

    final data = jsonDecode(response.body);

    if (data['url'] == null) {
      return Left(OAuthException(code: '02'));
    }

    return Right(data['url']);
  }

  /// Listens for the redirect URL.
  Future<Either<AuthException, Uri>> _listenForRedirect(Uri redirectUri) async {
    bool redirectProcessed = false;
    await for (final uri in appLinks.uriLinkStream) {
      if (redirectProcessed) {
        break;
      }
      if (uri.toString().startsWith(redirectUri.toString())) {
        redirectProcessed = true;
        return Right(uri);
      }
    }
    return Left(OAuthException(code: '03'));
  }
}
