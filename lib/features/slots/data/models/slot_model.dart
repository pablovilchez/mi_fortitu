import '../../domain/entities/slot_entity.dart';

class SlotModel extends SlotEntity {
  const SlotModel({
    required super.id,
    required super.beginAt,
    required super.endAt,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'],
      beginAt: DateTime.parse(json['begin_at']),
      endAt: DateTime.parse(json['end_at']),
    );
  }

  SlotEntity toEntity() {
    return SlotEntity(
      id: id,
      beginAt: beginAt,
      endAt: endAt,
    );
  }
}
