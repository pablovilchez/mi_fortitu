part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class IntraEventsInitial extends EventsState {}

final class IntraEventsLoading extends EventsState {}

final class IntraEventsSuccess extends EventsState {
  final List<EventVm> events;
  final String loginName;
  final int userId;
  final int campusId;

  IntraEventsSuccess(this.events, this.loginName, this.userId, this.campusId);

  IntraEventsSuccess copyWithRefreshedEvents(List<EventVm> refreshedEvents) {
    return IntraEventsSuccess(refreshedEvents, loginName, userId, campusId);
  }

  IntraEventsSuccess copyWithUpdatedEvent(EventVm updatedEvent) {
    final updatedList = events.map((event) {
      return event.details.id == updatedEvent.details.id ? updatedEvent : event;
    }).toList();

    return IntraEventsSuccess(updatedList, loginName, userId, campusId);
  }

}

final class IntraEventsError extends EventsState {
  final String message;

  IntraEventsError(this.message);
}