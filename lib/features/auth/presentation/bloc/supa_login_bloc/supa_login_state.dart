part of 'supa_login_bloc.dart';


abstract class SupaLoginState {}

final class LandingState extends SupaLoginState {}

final class LoginFormState extends SupaLoginState {}

final class RegisterFormState extends SupaLoginState {}

final class LoadingState extends SupaLoginState {}

final class LoginSuccess extends SupaLoginState {}

final class LoginError extends SupaLoginState {
  final String message;

  LoginError(this.message);
}

final class RegisterError extends SupaLoginState {
  final String message;

  RegisterError(this.message);
}

final class RegisterSuccess extends SupaLoginState {}

final class WaitlistState extends SupaLoginState {}
