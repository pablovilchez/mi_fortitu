/// A configuration class that reads required environment variables
/// for connecting with external services like Intra42 and Supabase.
///
/// This class validates the presence of all required variables at runtime.
/// Throws an [Exception] if any required variable is missing or empty.
class EnvConfig {
  /// The redirect URI used for Intra42 OAuth authentication flow.
  final String redirectUri;

  /// The URL of the Supabase Edge Function that exchanges the authorization code for an access token.
  final String codeForTokenFunctionUrl;

  /// The URL of the Supabase Edge Function that returns the Intra42 authorization URL.
  final String getAuthUrlFunctionUrl;

  /// The URL of the Supabase Edge Function that refreshes the Intra42 access token.
  final String refreshTokenFunctionUrl;

  /// The required scope for the Intra42 OAuth token.
  final String intraTokenScope;

  /// The base URL of the Supabase project.
  final String supaUrl;

  /// The Supabase anonymous public key used for client-side access.
  final String supaAnonKey;

  /// The version of the application.
  final String appVersion;

  /// Constructs an [EnvConfig] instance from a [Map] of environment variables.
  ///
  /// All values are validated; an [Exception] is thrown if any required key is
  /// missing or has an empty value.
  EnvConfig.from(Map<String, String> env)
    : redirectUri = _get(env, 'INTRA_REDIRECT_URI'),
      codeForTokenFunctionUrl = _get(env, 'CODE_FOR_TOKEN_FUNCTION_URL'),
      getAuthUrlFunctionUrl = _get(env, 'GET_AUTH_URL_FUNCTION_URL'),
      refreshTokenFunctionUrl = _get(env, 'REFRESH_TOKEN_FUNCTION_URL'),
      intraTokenScope = 'public profile projects',
      supaUrl = _get(env, 'SUPA_URL'),
      supaAnonKey = _get(env, 'SUPA_ANON_KEY'),
      appVersion = _get(env, 'APP_VERSION');

  /// Retrieves the value for the given [key] from the [env] map.
  ///
  /// Throws an [Exception] if the key is not found or its value is empty.
  static String _get(Map<String, String> env, String key) {
    final value = env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Missing or empty env variable: $key');
    }
    return value;
  }
}
