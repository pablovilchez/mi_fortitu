import '../../domain/entities/slot_entity.dart';

class SlotModel extends SlotEntity {
  const SlotModel({
    required super.id,
    required super.beginAt,
    required super.endAt,
    super.scaleTeam,
    required super.user,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'],
      beginAt: DateTime.parse(json['begin_at']),
      endAt: DateTime.parse(json['end_at']),
      scaleTeam: json['scale_team'] != null
          ? ScaleTeamModel.fromJson(json['scale_team'])
          : null,
      user: SlotUserModel.fromJson(json['user']),
    );
  }

  SlotEntity toEntity() {
    return SlotEntity(
      id: id,
      beginAt: beginAt,
      endAt: endAt,
      scaleTeam: scaleTeam,
      user: user,
    );
  }
}

class ScaleTeamModel extends ScaleTeam {
  const ScaleTeamModel({
    required super.id,
    required super.scaleId,
    required super.comment,
    required super.feedback,
    required super.finalMark,
    required super.correctedsLogins,
  });

  factory ScaleTeamModel.fromJson(Map<String, dynamic> json) {
    return ScaleTeamModel(
      id: json['id'],
      scaleId: json['scale_id'],
      comment: json['comment'],
      feedback: json['feedback'],
      finalMark: json['final_mark'],
      correctedsLogins: json['correcteds'].map((e) => e['login']).toList().cast<String>(),
    );
  }

  ScaleTeam toEntity() {
    return ScaleTeam(
      id: id,
      scaleId: scaleId,
      comment: comment,
      feedback: feedback,
      finalMark: finalMark,
      correctedsLogins: correctedsLogins,
    );
  }
}

class SlotUserModel extends SlotUser {
  const SlotUserModel({
    required super.id,
    required super.name,
    required super.loginName,
    required super.photoUrl,
  });

  factory SlotUserModel.fromJson(Map<String, dynamic> json) {
    return SlotUserModel(
      id: json['id'],
      name: json['first_name'],
      loginName: json['login'],
      photoUrl: json["image"]["versions"]["small"],
    );
  }

  SlotUser toEntity() {
    return SlotUser(
      id: id,
      name: name,
      loginName: loginName,
      photoUrl: photoUrl,
    );
  }
}