part of 'coalitions_blocs_bloc.dart';

@immutable
sealed class CoalitionsBlocsState {}

final class IntraCoalitionsInitial extends CoalitionsBlocsState {}

final class IntraCoalitionsLoading extends CoalitionsBlocsState {}

final class IntraCoalitionsSuccess extends CoalitionsBlocsState {
  final CoalitionsBlocsEntity coalitions;

  IntraCoalitionsSuccess(this.coalitions);
}

final class IntraCoalitionsError extends CoalitionsBlocsState {
  final String errorMessage;

  IntraCoalitionsError(this.errorMessage);
}
