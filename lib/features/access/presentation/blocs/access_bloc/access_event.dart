part of 'access_bloc.dart';

@immutable
sealed class AccessEvent {}

class LandingEvent extends AccessEvent {}

class RequestDbLoginEvent extends AccessEvent {
  final String email;
  final String password;

  RequestDbLoginEvent({required this.email, required this.password});
}

class RequestDbRegisterEvent extends AccessEvent {
  final String email;
  final String password;

  RequestDbRegisterEvent({
    required this.email,
    required this.password,
  });
}

class ToggleFormEvent extends AccessEvent {}

class CheckRolEvent extends AccessEvent {}
