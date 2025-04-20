class PeerEntity {
  final String loginName;
  final String photoUrl;
  final String location;
  final bool isOnline;

  const PeerEntity({
    required this.loginName,
    required this.photoUrl,
    required this.location,
    required this.isOnline,
  });
}