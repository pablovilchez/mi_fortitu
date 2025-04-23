part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final UserEntity profile;

  UserProfileSuccess(this.profile);
}

final class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);
}
