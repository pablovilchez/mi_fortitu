part of 'login_bloc.dart';


abstract class LoginState {}

final class LandingState extends LoginState {}

final class LoginFormState extends LoginState {}

final class RegisterFormState extends LoginState {}

final class LoadingState extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

final class RegisterError extends LoginState {
  final String message;

  RegisterError(this.message);
}

final class RegisterSuccess extends LoginState {}

final class WaitlistState extends LoginState {}
