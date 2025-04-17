import '../../domain/entities/project_user_entity.dart';

class ProjectUserModel extends ProjectUserEntity {
  ProjectUserModel({
    required super.id,
    required super.occurrence,
    required super.finalMark,
    required super.status,
    required super.validated,
    required super.currentTeamId,
    required super.project,
    required super.cursusIds,
    required super.markedAt,
    required super.marked,
    required super.retriableAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectUserModel.fromJson(Map<String, dynamic> json) {
    return ProjectUserModel(
      id: json["id"],
      occurrence: json["occurrence"] ?? 0,
      finalMark: json["final_mark"] ?? 0,
      status: json["status"] ?? 'undefined',
      validated: json["validated?"] ?? false,
      currentTeamId: json["current_team_id"] ?? -1,
      project: ProjectModel.fromJson(json["project"]),
      cursusIds: List<int>.from(json["cursus_ids"].map((x) => x)),
      markedAt: json["marked_at"] ?? "",
      marked: json["marked"] ?? false,
      retriableAt: json["retriable_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  ProjectUserEntity toEntity() {
    return ProjectUserEntity(
      id: id,
      occurrence: occurrence,
      finalMark: finalMark,
      status: status,
      validated: validated,
      currentTeamId: currentTeamId,
      project: project,
      cursusIds: cursusIds,
      markedAt: markedAt,
      marked: marked,
      retriableAt: retriableAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.parentId,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json["id"],
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      parentId: json["parent_id"] ?? 0,
    );
  }

  ProjectEntity toEntity() {
    return ProjectEntity(id: id, name: name, slug: slug, parentId: parentId);
  }
}