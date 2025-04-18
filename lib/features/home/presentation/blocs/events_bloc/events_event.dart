part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

class GetIntraEventsEvent extends EventsEvent {
  final String loginName;
  final String campusId;

  GetIntraEventsEvent(this.loginName, this.campusId);
}
