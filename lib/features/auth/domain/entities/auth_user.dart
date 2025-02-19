class AuthUser {
  final String id;
  final String email;
  final String accessToken;
  final String refreshToken;

  AuthUser({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });
}
