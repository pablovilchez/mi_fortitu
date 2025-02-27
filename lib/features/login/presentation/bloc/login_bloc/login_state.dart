part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LandingState extends LoginState {}

final class LoginFormState extends LoginState {}

final class RegisterFormState extends LoginState {}

final class LoadingState extends LoginState {}

final class LoginSuccess extends LoginState {}

final class RequestError extends LoginState {
  final String message;

  RequestError(this.message);
}

final class RegisterSuccess extends LoginState {}

final class WaitlistState extends LoginState {}
