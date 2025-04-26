import 'package:mi_fortitu/features/home/domain/entities/reg_event_data_entity.dart';

class RegEventDataModel extends RegEventDataEntity {
  RegEventDataModel({
    required super.id,
    required super.eventId,
    required super.userId,
  });

  factory RegEventDataModel.fromJson(Map<String, dynamic> json) {
    return RegEventDataModel(
      id: json["id"] ?? -1,
      eventId: json["event_id"] ?? -1,
      userId: json["user_id"] ?? -1,
    );
  }

  RegEventDataEntity toEntity() {
    return RegEventDataEntity(
      id: id,
      eventId: eventId,
      userId: userId,
    );
  }
}
