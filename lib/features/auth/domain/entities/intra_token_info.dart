class IntraTokenInfo {
  final String accessToken;
  final String refreshToken;
  final DateTime expirationDate;

  IntraTokenInfo({
    required this.accessToken,
    required this.refreshToken,
    required this.expirationDate,
  });
}