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
  final String? errorMessage;

  IntraEventsSuccess(this.events, this.loginName, this.userId, this.campusId, {this.errorMessage});

  IntraEventsSuccess copyWith(
      {List<EventVm>? events,
      String? loginName,
      int? userId,
      int? campusId,
      String? errorMessage}) {
    return IntraEventsSuccess(
      events ?? this.events,
      loginName ?? this.loginName,
      userId ?? this.userId,
      campusId ?? this.campusId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class IntraEventsError extends EventsState {
  final String message;

  IntraEventsError(this.message);
}