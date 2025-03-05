part of 'intra_profile_bloc.dart';

@immutable
sealed class IntraProfileState {}

final class IntraProfileLoading extends IntraProfileState {}

final class IntraProfileSuccess extends IntraProfileState {
  final IntraProfile intraProfile;
  final ProfileSummaryVM profileSummary;

  IntraProfileSuccess(this.intraProfile)
  : profileSummary = ProfileSummaryVM.fromEntity(intraProfile);
}

final class IntraProfileError extends IntraProfileState {
  final String message;

  IntraProfileError(this.message);
}

