part of 'intra_profile_cubit.dart';

@immutable
sealed class IntraProfileState {}

final class IntraProfileLoading extends IntraProfileState {}

final class IntraProfileSuccess extends IntraProfileState {}

final class IntraProfileFailure extends IntraProfileState {}
