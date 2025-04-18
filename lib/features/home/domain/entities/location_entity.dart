class LocationEntity {
  final String host;
  final int campusId;
  final LocationUserEntity user;

  LocationEntity({
    required this.host,
    required this.campusId,
    required this.user,
  });
}

class LocationUserEntity {
  final int id;
  final String email;
  final String login;
  final String firstName;
  final String lastName;
  final String url;
  final String kind;
  final String imageUrl;
  final bool staff;
  final String poolMonth;
  final String poolYear;
  final int wallet;
  final bool alumni;
  final bool active;

  LocationUserEntity({
    required this.id,
    required this.email,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.url,
    required this.kind,
    required this.imageUrl,
    required this.staff,
    required this.poolMonth,
    required this.poolYear,
    required this.wallet,
    required this.alumni,
    required this.active,
  });
}