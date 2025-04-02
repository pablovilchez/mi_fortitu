import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/url_launcher_service.dart';


class AuthIntraDatasource {
  final http.Client httpClient;
  final AppLinks appLinks;
  final UrlLauncherService launcher;
  final Map<String, String> env;

  AuthIntraDatasource({
    required this.httpClient,
    required this.appLinks,
    required this.launcher,
    required this.env,
  });

  /// Gets the authorization URL for Intra authentication.
  Future<String> getAuthorizationUrl() async {
    final oAuthCodeFunctionUrl = env['OAUTH_CODE_FUNCTION_URL'];
    final tokenScope = env['INTRA_TOKEN_SCOPE'];
    final response = await httpClient.post(
      Uri.parse(oAuthCodeFunctionUrl!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'response_type': 'code',
        'scope': tokenScope,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get authorization URL: ${response.body}');
    }

    final data = jsonDecode(response.body);

    if (data['url'] == null) {
      throw Exception('Authorization URL not found in response');
    }

    return data['url'];
  }

  /// Handles the authentication process with Intra.
  Future<Map<String, dynamic>> authenticate() async {
    final redirectUri = env['REDIRECT_URI'];
    final authFunctionUrl = env['AUTH_FUNCTION_URL'];
    final authUrl = await getAuthorizationUrl();
    await launcher.redirect(Uri.parse(authUrl));

    final responseUrl = await _listenForRedirect(Uri.parse(redirectUri!));
    final code = responseUrl.queryParameters['code'];

    if (code == null) {
      throw Exception('Authorization code not found in response URL');
    }

    final response = await httpClient.post(
      Uri.parse(authFunctionUrl!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'grant_type': 'authorization_code', 'code': code}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to exchange code for token: ${response.body}');
    }

    return jsonDecode(response.body);
  }

  /// Listens for the redirect URL.
  Future<Uri> _listenForRedirect(Uri redirectUri) async {
    await for (final uri in appLinks.uriLinkStream) {
      if (uri.toString().startsWith(redirectUri.toString())) {
        return uri;
      }
    }
    throw Exception('Failed to listen for redirect');
  }

  /// Gets the token information from intra
  Future<Map<String, dynamic>> getTokenInfo(String accessToken) async {
    final intraTokenUrl = env['INTRA_TOKEN_URL'];
    final response = await httpClient.get(
      Uri.parse(intraTokenUrl!),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    return jsonDecode(response.body);
  }

  /// Refreshes the access token using the refresh token.
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final refreshTokenFunctionUrl = env['REFRESH_TOKEN_FUNCTION_URL'];
    final response = await httpClient.post(
      Uri.parse(refreshTokenFunctionUrl!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'grant_type': 'refresh_token', 'refresh_token': refreshToken}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to refresh token: ${response.body}');
    }

    return jsonDecode(response.body);
  }
}
