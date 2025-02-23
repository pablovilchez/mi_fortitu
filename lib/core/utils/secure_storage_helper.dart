import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  // Supabase names
  static const _supabaseAccessTokenKey = 'supabase_access_token';
  static const _supabaseRefreshTokenKey = 'supabase_refresh_token';

  // Intra 42 names
  static const _intra42ClientId = 'intra42_client_id';
  static const _intra42ClientSecret = 'intra42_client_secret';
  static const _intra42AccessTokenKey = 'intra42_access_token';
  static const _intra42RefreshTokenKey = 'intra42_refresh_token';

  // Generic method to get a token
  static Future<String?> _getToken(String key) async {
    return await _storage.read(key: key);
  }

  // Generic method to save a token
  static Future<void> _saveToken(String key, String token) async {
    await _storage.write(key: key, value: token);
  }

  // Generic method to delete a token
  static Future<void> _deleteToken(String key) async {
    await _storage.delete(key: key);
  }

  // Methods for Supabase tokens
  static Future<Map<String, String?>> getSupabaseTokens() async {
    return {
      'accessToken': await _getToken(_supabaseAccessTokenKey),
      'refreshToken': await _getToken(_supabaseRefreshTokenKey),
    };
  }

  static Future<void> saveSupabaseTokens(
    String accessToken,
    String refreshToken,
  ) async {
    await _saveToken(_supabaseAccessTokenKey, accessToken);
    await _saveToken(_supabaseRefreshTokenKey, refreshToken);
  }

  static Future<void> deleteSupabaseTokens() async {
    await _deleteToken(_supabaseAccessTokenKey);
    await _deleteToken(_supabaseRefreshTokenKey);
  }

  // Methods for Intra 42 tokens
  static Future<String?> getIntraAccessToken() async {
    return await _getToken(_intra42AccessTokenKey);
  }

  static Future<String?> getIntraRefreshToken() async {
    return await _getToken(_intra42RefreshTokenKey);
  }

  static Future<String?> getIntraClientId() async {
    return await _getToken(_intra42ClientId);
  }

  static Future<String?> getIntraClientSecret() async {
    return await _getToken(_intra42ClientSecret);
  }

  static Future<void> saveIntraTokens(
    String accessToken,
    String refreshToken,
  ) async {
    await _saveToken(_intra42AccessTokenKey, accessToken);
    await _saveToken(_intra42RefreshTokenKey, refreshToken);
  }

  static Future<void> saveIntraCredentials(
    String clientId,
    String clientSecret,
  ) async {
    await _saveToken(_intra42ClientId, clientId);
    await _saveToken(_intra42ClientSecret, clientSecret);
  }

  static Future<void> deleteIntraTokens() async {
    await _deleteToken(_intra42AccessTokenKey);
    await _deleteToken(_intra42RefreshTokenKey);
  }
}
