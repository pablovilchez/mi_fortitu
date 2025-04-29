part of 'coalitions_blocs_bloc.dart';

@immutable
sealed class CoalitionsBlocsEvent {}

class GetCoalitionsEvent extends CoalitionsBlocsEvent {
  final int campusId;

  GetCoalitionsEvent({required this.campusId});
}
