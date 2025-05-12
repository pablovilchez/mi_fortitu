import '../../domain/entities/location_entity.dart';

/// LocationModel is a data model that represents a location in the campus.
class LocationModel extends LocationEntity {
  LocationModel({required super.host, required super.campusId, required super.user});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final host = json["host"];

    return LocationModel(
      host: host,
      campusId: json["campus_id"] ?? -1,
      user: LocationUserModel.fromJson(json["user"]),
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(host: host, campusId: campusId, user: user);
  }
}

/// LocationUserModel is a data model that represents a user in a campus location.
class LocationUserModel extends LocationUserEntity {
  LocationUserModel({
    required super.id,
    required super.email,
    required super.login,
    required super.firstName,
    required super.lastName,
    required super.url,
    required super.kind,
    required super.imageUrl,
    required super.staff,
    required super.poolMonth,
    required super.poolYear,
    required super.wallet,
    required super.alumni,
    required super.active,
  });

  factory LocationUserModel.fromJson(Map<String, dynamic> json) {
    return LocationUserModel(
      id: json["id"],
      email: json["email"] ?? "",
      login: json["login"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      url: json["url"] ?? "",
      kind: json["kind"] ?? "",
      imageUrl: json["image"]["versions"]["small"] ?? "",
      staff: json["staff"] ?? false,
      poolMonth: json["pool_month"] ?? "",
      poolYear: json["pool_year"] ?? "",
      wallet: json["wallet"] ?? 0,
      alumni: json["alumni"] ?? false,
      active: json["active"] ?? false,
    );
  }
}