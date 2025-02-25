import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mi_fortitu/core/utils/secure_storage_helper.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import 'package:mi_fortitu/features/login/data/models/intra_login_model.dart';
import 'package:mi_fortitu/features/login/domain/failures.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';

/// A repository for handling Intra app account authentication.
///
/// This repository is used to handle the authentication of Intra app accounts.
/// It provides methods for creating a client and handling the OAuth2 flow.
class IntraLoginRepository {
  /// Creates a new Intra app client.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [IntraLoginModel] if successful.
  Future<Either<Failure, IntraLoginModel>> createClient() async {
    try {
      late oauth2.Client client;
      final clientId = dotenv.env['INTRA_CLIENT_ID'];
      final clientSecret = dotenv.env['INTRA_CLIENT_SECRET'];
      final authUrl = dotenv.env['INTRA_AUTH_URL'];
      final tokenUrl = dotenv.env['INTRA_TOKEN_URL'];
      final redirectUri = dotenv.env['INTRA_REDIRECT_URI'];
      final clientToken = await SecureStorageHelper.getIntraAccessToken();
      final refreshToken = await SecureStorageHelper.getIntraRefreshToken();

      if (clientId == null ||
          clientSecret == null ||
          authUrl == null ||
          tokenUrl == null ||
          redirectUri == null) {
        return Left(EnvDataFailure('Missing environment data'));
      }

      if (clientToken != null && refreshToken != null) {
        final credentials = oauth2.Credentials(
          clientToken.toString(),
          refreshToken: refreshToken.toString(),
          tokenEndpoint: Uri.parse(dotenv.env['INTRA_TOKEN_URL']!),
        );
        client = oauth2.Client(credentials);
        return Right(IntraLoginModel.fromIntraClient(client));
      }

      final grant = oauth2.AuthorizationCodeGrant(
        clientId,
        Uri.parse(authUrl),
        Uri.parse(tokenUrl),
        secret: clientSecret,
      );
      var authorizationUrl = grant.getAuthorizationUrl(
        Uri.parse(redirectUri),
        scopes: ['public', 'profile'],
      );
      await _redirect(authorizationUrl);
      var responseUrl = await _listen(Uri.parse(redirectUri));
      client = await grant.handleAuthorizationResponse(
        responseUrl.queryParameters,
      );
      await SecureStorageHelper.saveIntraTokens(
        client.credentials.accessToken,
        client.credentials.refreshToken!,
      );

      return Right(IntraLoginModel.fromIntraClient(client));
    } catch (e) {
      return Left(IntraLoginFailure('Failed to create client: $e'));
    }
  }

  /// Redirects the user to the authorization URL.
  ///
  /// This method redirects the user to the authorization URL for the Intra app.
  ///
  /// Throws an [Exception] if the URL cannot be launched.
  Future<void> _redirect(Uri authorizationUrl) async {
    final bool canLaunch = await canLaunchUrl(authorizationUrl);

    if (!canLaunch) {
      throw Exception('Could not launch $authorizationUrl');
    }

    final bool launched = await launchUrl(
      authorizationUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      throw Exception('Could not launch URL: $authorizationUrl');
    }
  }

  /// Listens for the redirect URL.
  ///
  /// This method listens for the redirect URL after the user has authorized the app.
  ///
  /// Throws an [Exception] if the URL cannot be listened to.
  Future<Uri> _listen(Uri redirectUri) async {
    final appLinks = AppLinks();
    final linkStream = appLinks.uriLinkStream;

    await for (final uri in linkStream) {
      if (uri.toString().startsWith(redirectUri.toString())) {
        return uri;
      }
    }
    throw Exception('Failed to listen for redirect');
  }
}
