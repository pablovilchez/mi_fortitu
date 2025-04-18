part of 'intra_search_profile_bloc.dart';

@immutable
sealed class IntraSearchProfileState {}

final class IntraSearchProfileInitial extends IntraSearchProfileState {}

final class IntraSearchProfileLoading extends IntraSearchProfileState {}

final class IntraSearchProfileSuccess extends IntraSearchProfileState {
  final UserEntity intraSearchProfile;

  IntraSearchProfileSuccess(this.intraSearchProfile);
}

final class IntraSearchProfileError extends IntraSearchProfileState {
  final String message;

  IntraSearchProfileError(this.message);
}

