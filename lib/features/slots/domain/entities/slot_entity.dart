class SlotEntity {
  final int id;
  final DateTime beginAt;
  final DateTime endAt;
  final ScaleTeam? scaleTeam;
  final SlotUser user;

  const SlotEntity({
    required this.id,
    required this.beginAt,
    required this.endAt,
    this.scaleTeam,
    required this.user,
  });
}

class ScaleTeam {
  final int id;
  final int scaleId;
  final String comment;
  final String feedback;
  final int finalMark;
  final List<String> correctedsLogins;

  const ScaleTeam({
    required this.id,
    required this.scaleId,
    required this.comment,
    required this.feedback,
    required this.finalMark,
    required this.correctedsLogins,
  });
}

class SlotUser {
  final int id;
  final String name;
  final String loginName;
  final String photoUrl;

  const SlotUser({
    required this.id,
    required this.name,
    required this.loginName,
    required this.photoUrl,
  });
}