part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserEntity profile;
  final IntraProfileSummaryVM profileSummary;

  UserSuccess(this.profile)
  : profileSummary = IntraProfileSummaryVM.fromEntity(profile);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}
