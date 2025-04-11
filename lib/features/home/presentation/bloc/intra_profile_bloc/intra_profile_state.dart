part of 'intra_profile_bloc.dart';

@immutable
sealed class IntraProfileState {}

final class IntraProfileInitial extends IntraProfileState {}

final class IntraProfileLoading extends IntraProfileState {}

final class IntraProfileSuccess extends IntraProfileState {
  final IntraProfileEntity intraProfile;
  final IntraProfileSummaryVM profileSummary;

  IntraProfileSuccess(this.intraProfile)
  : profileSummary = IntraProfileSummaryVM.fromEntity(intraProfile);
}

final class IntraProfileError extends IntraProfileState {
  final String message;

  IntraProfileError(this.message);
}

