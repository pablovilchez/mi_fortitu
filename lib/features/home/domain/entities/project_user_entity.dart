class ProjectUserEntity {
  int id;
  int occurrence;
  int finalMark;
  String status;
  bool validated;
  int currentTeamId;
  ProjectEntity project;
  List<int> cursusIds;
  String markedAt;
  bool marked;
  String retriableAt;
  String createdAt;
  String updatedAt;

  ProjectUserEntity({
    required this.id,
    required this.occurrence,
    required this.finalMark,
    required this.status,
    required this.validated,
    required this.currentTeamId,
    required this.project,
    required this.cursusIds,
    required this.markedAt,
    required this.marked,
    required this.retriableAt,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ProjectEntity {
  int id;
  String name;
  String slug;
  int parentId;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.parentId,
  });
}
