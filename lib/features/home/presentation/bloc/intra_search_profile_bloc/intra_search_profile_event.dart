part of 'intra_search_profile_bloc.dart';

@immutable
sealed class IntraSearchProfileEvent {}

final class GetIntraSearchProfileEvent extends IntraSearchProfileEvent {
  final String login;

  GetIntraSearchProfileEvent(this.login);
}

