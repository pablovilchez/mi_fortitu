part of 'intra_profile_bloc.dart';

@immutable
sealed class IntraProfileEvent {}

final class GetIntraProfileEvent extends IntraProfileEvent {
  final String login;

  GetIntraProfileEvent(this.login);
}

