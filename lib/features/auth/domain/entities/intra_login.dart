class IntraLogin {
  final String token;
  final String? refreshToken;
  final DateTime? expiryDate;

  IntraLogin({
    required this.token,
    this.refreshToken,
    this.expiryDate,
  });
}