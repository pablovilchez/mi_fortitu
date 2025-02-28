part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LandingEvent extends LoginEvent {}

class RequestLoginEvent extends LoginEvent {
  final String email;
  final String password;

  RequestLoginEvent({required this.email, required this.password});
}

class RequestRegisterEvent extends LoginEvent {
  final String email;
  final String password;

  RequestRegisterEvent({
    required this.email,
    required this.password,
  });
}

class CheckIntraAuthEvent extends LoginEvent {}

class CheckRolEvent extends LoginEvent {}

class ToggleFormEvent extends LoginEvent {}