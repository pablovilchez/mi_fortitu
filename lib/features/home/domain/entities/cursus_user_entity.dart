class CursusUserEntity {
  int id;
  String beginAt;
  String endAt;
  String grade;
  double level;
  List<CursusSkillEntity> skills;
  int cursusId;
  bool hasCoalition;
  String blackholedAt;
  String createdAt;
  String updatedAt;
  CursusEntity cursus;

  CursusUserEntity({
    required this.id,
    required this.beginAt,
    required this.endAt,
    required this.grade,
    required this.level,
    required this.skills,
    required this.cursusId,
    required this.hasCoalition,
    required this.blackholedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.cursus,
  });
}

class CursusSkillEntity {
  int id;
  String name;
  double level;

  CursusSkillEntity({
    required this.id,
    required this.name,
    required this.level,
  });
}

class CursusEntity {
  int id;
  String createdAt;
  String name;
  String slug;
  String kind;

  CursusEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.slug,
    required this.kind,
  });
}