class ClusterUserEntity {
  final String host;
  final int cluster;
  final int row;
  final int station;
  final int campusId;
  final User user;

  ClusterUserEntity({
    required this.host,
    required this.cluster,
    required this.row,
    required this.station,
    required this.campusId,
    required this.user,
  });
}

class User {
  final int id;
  final String login;
  final String firstName;
  final String lastName;
  final String kind;
  final Image image;
  final bool staff;
  final int correctionPoint;
  final String poolMonth;
  final String poolYear;
  final bool alumni;

  User({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.kind,
    required this.image,
    required this.staff,
    required this.correctionPoint,
    required this.poolMonth,
    required this.poolYear,
    required this.alumni,
  });
}

class Image {
  final String small;
  final String micro;

  Image({
    required this.small,
    required this.micro,
  });
}
