import 'package:mi_fortitu/features/home/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    required super.id,
    required super.name,
    required super.description,
    required super.location,
    required super.kind,
    required super.maxPeople,
    required super.nbrSubscribers,
    required super.beginAt,
    required super.endAt,
    required super.campusIds,
    required super.cursusIds,
    required super.createdAt,
    required super.updatedAt,
    required super.prohibitionOfCancellation,
    required super.waitlist,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      name: json["name"] ?? "unknown",
      description: json["description"] ?? "unknown",
      location: json["location"] ?? "unknown",
      kind: json["kind"] ?? "unknown",
      maxPeople: json["max_people"] ?? 0,
      nbrSubscribers: json["nbr_subscribers"] ?? 0,
      beginAt: DateTime.parse(json["begin_at"]).toLocal(),
      endAt: DateTime.parse(json["end_at"]).toLocal(),
      campusIds: List<int>.from(json["campus_ids"].map((x) => x)),
      cursusIds: List<int>.from(json["cursus_ids"].map((x) => x)),
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      prohibitionOfCancellation: json["prohibition_of_cancellation"],
      waitlist: json["waitlist"] == null ? null : WaitlistModel.fromJson(json["waitlist"]),
    );
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      name: name,
      description: description,
      location: location,
      kind: kind,
      maxPeople: maxPeople,
      nbrSubscribers: nbrSubscribers,
      beginAt: beginAt,
      endAt: endAt,
      campusIds: campusIds,
      cursusIds: cursusIds,
      createdAt: createdAt,
      updatedAt: updatedAt,
      prohibitionOfCancellation: prohibitionOfCancellation,
      waitlist: waitlist,
    );
  }
}

class WaitlistModel extends Waitlist {
  WaitlistModel({
    required super.id,
    required super.waitlistableId,
    required super.waitlistableType,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WaitlistModel.fromJson(Map<String, dynamic> json) {
    return WaitlistModel(
      id: json["id"],
      waitlistableId: json["waitlistable_id"] ?? 0,
      waitlistableType: json["waitlistable_type"] ?? "unknown",
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
}