class EventEntity {
  int eventId;
  String name;
  String description;
  String location;
  String kind;
  int maxPeople;
  int nbrSubscribers;
  DateTime beginAt;
  DateTime endAt;
  List<int> campusIds;
  List<int> cursusIds;
  WaitlistEntity? waitlist;

  EventEntity({
    required this.eventId,
    required this.name,
    required this.description,
    required this.location,
    required this.kind,
    required this.maxPeople,
    required this.nbrSubscribers,
    required this.beginAt,
    required this.endAt,
    required this.campusIds,
    required this.cursusIds,
    required this.waitlist,
  });

  factory EventEntity.empty() {
    return EventEntity(
      eventId: -1,
      name: '',
      description: '',
      location: '',
      kind: '',
      maxPeople: 0,
      nbrSubscribers: 0,
      beginAt: DateTime.now(),
      endAt: DateTime.now(),
      campusIds: [],
      cursusIds: [],
      waitlist: null,
    );
  }
}


class WaitlistEntity {
  int id;
  int waitlistableId;
  String waitlistableType;

  WaitlistEntity({
    required this.id,
    required this.waitlistableId,
    required this.waitlistableType,
  });
}
