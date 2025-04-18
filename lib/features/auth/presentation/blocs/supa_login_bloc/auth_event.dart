part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LandingEvent extends AuthEvent {}

class RequestDbLoginEvent extends AuthEvent {
  final String email;
  final String password;

  RequestDbLoginEvent({required this.email, required this.password});
}

class RequestDbRegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RequestDbRegisterEvent({
    required this.email,
    required this.password,
  });
}

class ToggleFormEvent extends AuthEvent {}

class CheckRolEvent extends AuthEvent {}
