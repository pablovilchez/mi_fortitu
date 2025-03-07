part of 'intra_events_bloc.dart';

@immutable
sealed class IntraEventsState {}

final class IntraEventsInitial extends IntraEventsState {}

final class IntraEventsLoading extends IntraEventsState {}

final class IntraEventsSuccess extends IntraEventsState {
  final List<IntraEvent> events;

  IntraEventsSuccess(this.events);
}

final class IntraEventsError extends IntraEventsState {
  final String message;

  IntraEventsError(this.message);
}