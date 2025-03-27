import 'package:app_links/app_links.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/secure_storage_helper.dart';

/// A data source for handling Intra app account authentication.
class AuthIntraDatasource {
  /// Creates a new Intra app client.
  Future<oauth2.Client> getIntraClient() async {
    final clientId = dotenv.env['INTRA_CLIENT_ID'];
    final clientSecret = dotenv.env['INTRA_CLIENT_SECRET'];
    final authUrl = dotenv.env['INTRA_AUTH_URL'];
    final tokenUrl = dotenv.env['INTRA_TOKEN_URL'];
    final redirectUri = dotenv.env['INTRA_REDIRECT_URI'];

    if ([clientId, clientSecret, authUrl, tokenUrl, redirectUri].contains(null)) {
      throw Exception('Missing environment data');
    }

    final clientToken = await SecureStorageHelper.getIntraAccessToken();
    final refreshToken = await SecureStorageHelper.getIntraRefreshToken();

    if (clientToken != null && refreshToken != null) {
      final credentials = oauth2.Credentials(
        clientToken,
        refreshToken: refreshToken,
        tokenEndpoint: Uri.parse(tokenUrl!),
      );
      return oauth2.Client(credentials);
    }

    final grant = oauth2.AuthorizationCodeGrant(
      clientId!,
      Uri.parse(authUrl!),
      Uri.parse(tokenUrl!),
      secret: clientSecret,
    );

    final authorizationUrl = grant.getAuthorizationUrl(
      Uri.parse(redirectUri!),
      scopes: ['public', 'profile'],
    );

    await _redirect(authorizationUrl);

    final responseUrl = await _listen(Uri.parse(redirectUri));
    final client = await grant.handleAuthorizationResponse(responseUrl.queryParameters);

    await SecureStorageHelper.saveIntraTokens(
      client.credentials.accessToken,
      client.credentials.refreshToken!,
    );

    return client;
  }

  /// Redirects to the authorization URL.
  Future<void> _redirect(Uri authorizationUrl) async {
    if (!await canLaunchUrl(authorizationUrl)) {
      throw Exception('Could not launch $authorizationUrl');
    }

    if (!await launchUrl(authorizationUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch URL: $authorizationUrl');
    }
  }

  /// Listens for the redirect URL.
  Future<Uri> _listen(Uri redirectUri) async {
    final appLinks = AppLinks();

    await for (final uri in appLinks.uriLinkStream) {
      if (uri.toString().startsWith(redirectUri.toString())) {
        return uri;
      }
    }
    throw Exception('Failed to listen for redirect');
  }
}
