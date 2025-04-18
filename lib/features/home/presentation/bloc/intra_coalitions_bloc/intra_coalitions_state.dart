part of 'intra_coalitions_bloc.dart';

@immutable
sealed class IntraCoalitionsState {}

final class IntraCoalitionsInitial extends IntraCoalitionsState {}

final class IntraCoalitionsLoading extends IntraCoalitionsState {}

final class IntraCoalitionsSuccess extends IntraCoalitionsState {
  final BlocEntity coalitions;

  IntraCoalitionsSuccess(this.coalitions);
}

final class IntraCoalitionsError extends IntraCoalitionsState {
  final String errorMessage;

  IntraCoalitionsError(this.errorMessage);
}
