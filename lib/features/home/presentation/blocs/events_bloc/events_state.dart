part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class IntraEventsInitial extends EventsState {}

final class IntraEventsLoading extends EventsState {}

final class IntraEventsSuccess extends EventsState {
  final List<EventVm> events;

  IntraEventsSuccess(this.events);
}

final class IntraEventsError extends EventsState {
  final String message;

  IntraEventsError(this.message);
}