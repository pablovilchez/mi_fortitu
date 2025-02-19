import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  // Keys for Supabase tokens
  static const _supabaseAccessTokenKey = 'supabase_access_token';
  static const _supabaseRefreshTokenKey = 'supabase_refresh_token';

  // Keys for Intra 42 tokens
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
  static Future<Map<String, String?>> getIntra42Tokens() async {
    return {
      'accessToken': await _getToken(_intra42AccessTokenKey),
      'refreshToken': await _getToken(_intra42RefreshTokenKey),
    };
  }

  static Future<void> saveIntra42Tokens(
    String accessToken,
    String refreshToken,
  ) async {
    await _saveToken(_intra42AccessTokenKey, accessToken);
    await _saveToken(_intra42RefreshTokenKey, refreshToken);
  }

  static Future<void> deleteIntra42Tokens() async {
    await _deleteToken(_intra42AccessTokenKey);
    await _deleteToken(_intra42RefreshTokenKey);
  }
}
