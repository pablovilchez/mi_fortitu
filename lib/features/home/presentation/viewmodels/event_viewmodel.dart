import 'package:easy_localization/easy_localization.dart';
import 'package:mi_fortitu/core/helpers/date_format_helper.dart';

import '../../domain/entities/event_entity.dart';

class EventVm {
  final EventDetailsVm details;
  final bool isFull;
  final bool isWaitlisted;
  final bool isClosed;
  final int userId;
  final EventStatus status;
  final int registerId;

  EventVm({
    required this.details,
    required this.isFull,
    this.isWaitlisted = false,
    this.isClosed = false,
    required this.userId,
    required this.status,
    required this.registerId,
  });

  EventVm copyWith({
    EventStatus? status,
    int? registerId,
  }) {
    return EventVm(
      details: details,
      isFull: isFull,
      isWaitlisted: isWaitlisted,
      isClosed: isClosed,
      userId: userId,
      status: status ?? this.status,
      registerId: registerId ?? this.registerId,
    );
  }

  factory EventVm.empty() {
    return EventVm(
      details: EventDetailsVm(
        id: 0,
        name: '',
        description: '',
        location: '',
        kind: '',
        maxPeople: 0,
        nbrSubscribers: 0,
        beginAt: DateTime.now(),
        beginLapse: '',
        beginDate: '',
        beginWeekDay: '',
        beginDay: '',
        beginMonth: '',
        beginTime: '',
        duration: '',
      ),
      isFull: false,
      isWaitlisted: false,
      isClosed: false,
      userId: 0,
      status: EventStatus.loading,
      registerId: 0,
    );
  }

}

enum EventStatus {
  subscribed,
  notSubscribed,
  waitlisted,
  unwaitlisted,
  loading,
  failed,
}

class EventDetailsVm {
  final int id;
  final String name;
  final String description;
  final String location;
  final String kind;
  final int maxPeople;
  final int nbrSubscribers;
  final DateTime beginAt;
  final String beginLapse;
  final String beginDate;
  final String beginWeekDay;
  final String beginDay;
  final String beginMonth;
  final String beginTime;
  final String duration;

  EventDetailsVm({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.kind,
    required this.maxPeople,
    required this.nbrSubscribers,
    required this.beginAt,
    required this.beginLapse,
    required this.beginDate,
    required this.beginWeekDay,
    required this.beginDay,
    required this.beginMonth,
    required this.beginTime,
    required this.duration,
  });

  factory EventDetailsVm.fromEntity(EventEntity entity) {
    return EventDetailsVm(
      id: entity.eventId,
      name: entity.name,
      description: entity.description,
      location: entity.location,
      kind: entity.kind,
      maxPeople: entity.maxPeople,
      nbrSubscribers: entity.nbrSubscribers,
      beginAt: entity.beginAt,
      beginLapse: DateFormatHelper.timeToStartStr(entity.beginAt),
      beginDate: DateFormat('Md', tr('language')).format(entity.beginAt),
      beginWeekDay: DateFormat('EEEE', tr('language')).format(entity.beginAt),
      beginDay: DateFormat('d', tr('language')).format(entity.beginAt),
      beginMonth: DateFormat('MMMM', tr('language')).format(entity.beginAt),
      beginTime: DateFormat('HH:mm', tr('language')).format(entity.beginAt),
      duration: DateFormatHelper.timeLapseStr(entity.beginAt, entity.endAt),
    );
  }
}
