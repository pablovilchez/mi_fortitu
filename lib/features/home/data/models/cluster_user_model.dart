import '../../domain/entities/cluster_user_entity.dart';

class ClusterUserModel extends ClusterUserEntity {
  ClusterUserModel({required super.host, required super.campusId, required super.user});

  factory ClusterUserModel.fromJson(Map<String, dynamic> json) {
    final host = json["host"];

    return ClusterUserModel(
      host: host,
      campusId: json["campus_id"] ?? -1,
      user: UserModel.fromJson(json["user"]),
    );
  }

  ClusterUserEntity toEntity() {
    return ClusterUserEntity(host: host, campusId: campusId, user: user);
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
    id: json["id"] ?? -1,
    login: json["login"] ?? 'no_login',
    firstName: json["first_name"] ?? 'no_first_name',
    lastName: json["last_name"] ?? 'no_last_name',
    kind: json["kind"] ?? 'no_kind',
    image: ImageModel.fromJson(json["image"]),
    staff: json["staff?"] ?? false,
    correctionPoint: json["correction_point"] ?? -1,
    poolMonth: json["pool_month"] ?? 'no_pool_month',
    poolYear: json["pool_year"] ?? 'no_pool_year',
    alumni: json["alumni?"] ?? false,
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

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    small: json["versions"]["small"] ?? 'no_small_image',
    micro: json["versions"]["micro"] ?? 'no_micro_image',
  );

  Image toEntity() {
    return Image(small: small, micro: micro);
  }
}
