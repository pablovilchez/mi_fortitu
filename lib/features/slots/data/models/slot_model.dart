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
    final rawScaleTeam = json['scale_team'];

    return SlotModel(
      id: json['id'],
      beginAt: DateTime.parse(json['begin_at']),
      endAt: DateTime.parse(json['end_at']),
      scaleTeam:
          rawScaleTeam is Map<String, dynamic>
              ? ScaleTeamModel.fromJson(json['scale_team'])
              : rawScaleTeam == null
              ? null
              : ScaleTeamModel.empty(),
      user: SlotUserModel.fromJson(json['user']),
    );
  }

  SlotEntity toEntity() {
    return SlotEntity(id: id, beginAt: beginAt, endAt: endAt, scaleTeam: scaleTeam, user: user);
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
    final correcteds = json['correcteds'];
    final correctedsLogins =
        correcteds is List ? correcteds.map((e) => e['login']).toList().cast<String>() : <String>[];

    return ScaleTeamModel(
      id: json['id'],
      scaleId: json['scale_id'],
      comment: json['comment'] ?? '',
      feedback: json['feedback'] ?? '',
      finalMark: json['final_mark'] ?? 0,
      correctedsLogins: correctedsLogins,
    );
  }

  factory ScaleTeamModel.empty() {
    return const ScaleTeamModel(
      id: 0,
      scaleId: 0,
      comment: '',
      feedback: '',
      finalMark: 0,
      correctedsLogins: [],
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
    return SlotUser(id: id, name: name, loginName: loginName, photoUrl: photoUrl);
  }
}
