part of 'access_bloc.dart';

@immutable
sealed class AccessEvent {}

class LandingEvent extends AccessEvent {}

class ShowLoginFormEvent extends AccessEvent {}

class ShowRegisterFormEvent extends AccessEvent {}

class ShowResetPasswordFormEvent extends AccessEvent {}

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

class RequestDbRecoveryEmailEvent extends AccessEvent {
  final String email;

  RequestDbRecoveryEmailEvent({required this.email});
}

class RequestSetNewPasswordEvent extends AccessEvent {
  final String newPassword;

  RequestSetNewPasswordEvent({
    required this.newPassword,
  });
}

class ToggleFormEvent extends AccessEvent {}

class CheckRolEvent extends AccessEvent {}
