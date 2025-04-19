part of 'auth_bloc.dart';


abstract class AuthState {}

final class LandingState extends AuthState {}

final class LoginFormState extends AuthState {}

final class RegisterFormState extends AuthState {}

final class LoadingState extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

final class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}

final class RegisterSuccess extends AuthState {}

final class WaitlistState extends AuthState {}
