part of 'supa_login_bloc.dart';

@immutable
sealed class SupaLoginEvent {}

class LandingEvent extends SupaLoginEvent {}

class RequestLoginEvent extends SupaLoginEvent {
  final String email;
  final String password;

  RequestLoginEvent({required this.email, required this.password});
}

class RequestRegisterEvent extends SupaLoginEvent {
  final String email;
  final String password;

  RequestRegisterEvent({
    required this.email,
    required this.password,
  });
}

class CheckIntraAuthEvent extends SupaLoginEvent {}

class CheckRolEvent extends SupaLoginEvent {}

class ToggleFormEvent extends SupaLoginEvent {}