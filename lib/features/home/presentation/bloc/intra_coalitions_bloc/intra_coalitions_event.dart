part of 'intra_coalitions_bloc.dart';

@immutable
sealed class IntraCoalitionsEvent {}

class GetCoalitionsEvent extends IntraCoalitionsEvent {
  final String campusId;

  GetCoalitionsEvent({required this.campusId});
}
