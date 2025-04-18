part of 'profiles_bloc.dart';

@immutable
sealed class ProfilesEvent {}

final class GetIntraProfileEvent extends ProfilesEvent {}
