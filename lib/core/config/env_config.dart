import '../../features/auth/data/exceptions.dart';

class EnvConfig {
  final String redirectUri;
  final String codeForTokenFunctionUrl;
  final String getAuthUrlFunctionUrl;
  final String refreshTokenFunctionUrl;
  final String intraTokenScope;
  final String supaUrl;
  final String supaAnonKey;

  EnvConfig.from(Map<String, String> env)
      : redirectUri = _get(env, 'INTRA_REDIRECT_URI'),
        codeForTokenFunctionUrl = _get(env, 'CODE_FOR_TOKEN_FUNCTION_URL'),
        getAuthUrlFunctionUrl = _get(env, 'GET_AUTH_URL_FUNCTION_URL'),
        refreshTokenFunctionUrl = _get(env, 'REFRESH_TOKEN_FUNCTION_URL'),
        intraTokenScope = 'public profile',
        supaUrl = _get(env, 'SUPA_URL'),
        supaAnonKey = _get(env, 'SUPA_ANON_KEY');

  static String _get(Map<String, String> env, String key) {
    final value = env[key];
    if (value == null || value.isEmpty) {
      throw EnvException(code: 'E002', message: 'Missing or empty env variable: $key');
    }
    return value;
  }
}
