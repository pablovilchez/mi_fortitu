class IntraEvent {
  int id;
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
  String createdAt;
  String updatedAt;
  dynamic prohibitionOfCancellation;
  Waitlist? waitlist;
  bool isSubscribed = false;

  IntraEvent({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    required this.prohibitionOfCancellation,
    required this.waitlist,
  });

  factory IntraEvent.empty() {
    return IntraEvent(
      id: -1,
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
      createdAt: '',
      updatedAt: '',
      prohibitionOfCancellation: null,
      waitlist: null,
    );
  }
}


class Waitlist {
  int id;
  int waitlistableId;
  String waitlistableType;
  String createdAt;
  String updatedAt;

  Waitlist({
    required this.id,
    required this.waitlistableId,
    required this.waitlistableType,
    required this.createdAt,
    required this.updatedAt,
  });
}
