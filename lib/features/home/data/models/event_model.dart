import '../../domain/entities/event_entity.dart';

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
    required super.waitlist,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      name: json["name"] ?? "No name",
      description: json["description"] ?? "Undefined description",
      location: json["location"] ?? "Undefined location",
      kind: json["kind"] ?? "Undefined kind",
      maxPeople: json["max_people"] ?? -1,
      nbrSubscribers: json["nbr_subscribers"] ?? -1,
      beginAt: DateTime.parse(json["begin_at"]).toLocal(),
      endAt: DateTime.parse(json["end_at"]).toLocal(),
      campusIds: List<int>.from(json["campus_ids"].map((x) => x)),
      cursusIds: List<int>.from(json["cursus_ids"].map((x) => x)),
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
      waitlist: waitlist,
    );
  }
}

class WaitlistModel extends WaitlistEntity {
  WaitlistModel({
    required super.id,
    required super.waitlistableId,
    required super.waitlistableType,
  });

  factory WaitlistModel.fromJson(Map<String, dynamic> json) {
    return WaitlistModel(
      id: json["id"],
      waitlistableId: json["waitlistable_id"] ?? 0,
      waitlistableType: json["waitlistable_type"] ?? "unknown",
    );
  }
}