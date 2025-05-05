part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

class GetIntraEventsEvent extends EventsEvent {
  final String loginName;
  final int userId;
  final int campusId;

  GetIntraEventsEvent(this.loginName, this.userId, this.campusId);
}

class RefreshIntraEventsEvent extends EventsEvent {}

class SubscribeToEventEvent extends EventsEvent {
  final EventVm event;

  SubscribeToEventEvent(this.event);
}

class UnsubscribeFromEventEvent extends EventsEvent {
  final EventVm event;

  UnsubscribeFromEventEvent(this.event);
}

class ClearEventErrorMessageEvent extends EventsEvent {}
