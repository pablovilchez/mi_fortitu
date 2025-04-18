import '../../domain/entities/cursus_user_entity.dart';

class CursusUserModel extends CursusUserEntity {
  CursusUserModel({
    required super.id,
    required super.beginAt,
    required super.endAt,
    required super.grade,
    required super.level,
    required super.skills,
    required super.cursusId,
    required super.hasCoalition,
    required super.blackholedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.cursus,
  });

  factory CursusUserModel.fromJson(Map<String, dynamic> json) {
    return CursusUserModel(
      id: json["id"],
      beginAt: json["begin_at"] ?? "",
      endAt: json["end_at"] ?? "",
      grade: json["grade"] ?? "",
      level: json["level"]?.toDouble() ?? 0,
      skills: List<CursusSkillModel>.from(json["skills"].map((x) => CursusSkillModel.fromJson(x))),
      cursusId: json["cursus_id"],
      hasCoalition: json["has_coalition"] ?? false,
      blackholedAt: json["blackholed_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      cursus: CursusModel.fromJson(json["cursus"]),
    );
  }

  CursusUserEntity toEntity() {
    return CursusUserEntity(
      id: id,
      beginAt: beginAt,
      endAt: endAt,
      grade: grade,
      level: level,
      skills: skills,
      cursusId: cursusId,
      hasCoalition: hasCoalition,
      blackholedAt: blackholedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      cursus: cursus,
    );
  }
}

class CursusSkillModel extends CursusSkillEntity {
  CursusSkillModel({required super.id, required super.name, required super.level});

  factory CursusSkillModel.fromJson(Map<String, dynamic> json) {
    return CursusSkillModel(id: json["id"], name: json["name"] ?? "", level: json["level"]?.toDouble());
  }

  CursusSkillEntity toEntity() {
    return CursusSkillEntity(id: id, name: name, level: level);
  }
}

class CursusModel extends CursusEntity {
  CursusModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.slug,
    required super.kind,
  });

  factory CursusModel.fromJson(Map<String, dynamic> json) {
    return CursusModel(
      id: json["id"],
      createdAt: json["created_at"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      kind: json["kind"] ?? "",
    );
  }

  CursusEntity toEntity() {
    return CursusEntity(id: id, createdAt: createdAt, name: name, slug: slug, kind: kind);
  }
}