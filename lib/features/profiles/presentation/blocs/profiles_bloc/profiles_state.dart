part of 'profiles_bloc.dart';

@immutable
sealed class ProfilesState {}

final class ProfileInitial extends ProfilesState {}

final class ProfileLoading extends ProfilesState {}

final class ProfileSuccess extends ProfilesState {
  final UserEntity profile;
  final IntraProfileSummaryVM profileSummary;

  ProfileSuccess(this.profile)
  : profileSummary = IntraProfileSummaryVM.fromEntity(profile);
}

final class ProfileError extends ProfilesState {
  final String message;

  ProfileError(this.message);
}

