import '../../domain/entities/cursus_coalitions_entity.dart';

class CursusCoalitionsModel extends CursusCoalitionsEntity {
  CursusCoalitionsModel({
    required super.id,
    required super.campusId,
    required super.cursusId,
    required super.coalitions,
  });

  factory CursusCoalitionsModel.fromJson(Map<String, dynamic> json) {
    return CursusCoalitionsModel(
      id: json["id"] ?? -1,
      campusId: json["campus_id"] ?? -1,
      cursusId: json["cursus_id"] ?? -1,
      coalitions: List<CoalitionModel>.from(
        json["coalitions"].map((x) => CoalitionModel.fromJson(x)),
      ),
    );
  }

  CursusCoalitionsEntity toEntity() {
    return CursusCoalitionsEntity(
      id: id,
      campusId: campusId,
      cursusId: cursusId,
      coalitions: coalitions,
    );
  }
}

class CoalitionModel extends CoalitionEntity {
  CoalitionModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.imageUrl,
    required super.coverUrl,
    required super.color,
    required super.score,
    required super.userId,
  });

  factory CoalitionModel.fromJson(Map<String, dynamic> json) {
    return CoalitionModel(
      id: json["id"] ?? -1,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      imageUrl: json["image_url"] ?? "",
      coverUrl: json["cover_url"] ?? "",
      color: json["color"] ?? "",
      score: json["score"] ?? -1,
      userId: json["user_id"] ?? -1,
    );
  }

  CoalitionEntity toEntity() {
    return CoalitionEntity(
      id: id,
      name: name,
      slug: slug,
      imageUrl: imageUrl,
      coverUrl: coverUrl,
      color: color,
      score: score,
      userId: userId,
    );
  }
}
