part of 'intra_events_bloc.dart';

@immutable
sealed class IntraEventsEvent {}

class GetIntraEventsEvent extends IntraEventsEvent {
  final String loginName;
  final String campusId;

  GetIntraEventsEvent(this.loginName, this.campusId);
}
