part of 'coalitions_blocs_bloc.dart';

@immutable
sealed class CoalitionsBlocsEvent {}

class GetCoalitionsEvent extends CoalitionsBlocsEvent {
  final String campusId;

  GetCoalitionsEvent({required this.campusId});
}
