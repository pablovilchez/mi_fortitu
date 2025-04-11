import '../../domain/entities/cluster_user_entity.dart';

class ClusterUserModel extends ClusterUserEntity {
  ClusterUserModel({
    required super.host,
    required super.cluster,
    required super.row,
    required super.station,
    required super.campusId,
    required super.user,
  });

  factory ClusterUserModel.fromJson(Map<String, dynamic> json) {
    final host = json["host"];
    final regex = RegExp(r'c(\d+)r(\d+)s(\d+)').firstMatch(host);
    final cluster = int.parse(regex?.group(1) ?? '0');
    final row = int.parse(regex?.group(2) ?? '0');
    final station = int.parse(regex?.group(3) ?? '0');

    return ClusterUserModel(
      host: host,
      cluster: cluster,
      row: row,
      station: station,
      campusId: json["campus_id"],
      user: UserModel.fromJson(json["user"]),
    );
  }

  ClusterUserEntity toEntity() {
    return ClusterUserEntity(
      host: host,
      cluster: cluster,
      row: row,
      station: station,
      campusId: campusId,
      user: user,
    );
  }
}

class UserModel extends User {
  UserModel({
    required super.id,
    required super.login,
    required super.firstName,
    required super.lastName,
    required super.kind,
    required super.image,
    required super.staff,
    required super.correctionPoint,
    required super.poolMonth,
    required super.poolYear,
    required super.alumni,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    login: json["login"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    kind: json["kind"],
    image: ImageModel.fromJson(json["image"]),
    staff: json["staff?"],
    correctionPoint: json["correction_point"],
    poolMonth: json["pool_month"],
    poolYear: json["pool_year"],
    alumni: json["alumni?"],
  );

  User toEntity() {
    return User(
      id: id,
      login: login,
      firstName: firstName,
      lastName: lastName,
      kind: kind,
      image: image,
      staff: staff,
      correctionPoint: correctionPoint,
      poolMonth: poolMonth,
      poolYear: poolYear,
      alumni: alumni,
    );
  }
}

class ImageModel extends Image {
  ImageModel({required super.small, required super.micro});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(small: json["versions"]["small"], micro: json["versions"]["micro"]);

  Image toEntity() {
    return Image(
      small: small,
      micro: micro,
    );
  }
}
