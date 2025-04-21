part of 'access_bloc.dart';


abstract class AccessState {}

final class LandingState extends AccessState {}

final class LoginFormState extends AccessState {}

final class RegisterFormState extends AccessState {}

final class LoadingState extends AccessState {}

final class LoginSuccess extends AccessState {}

final class LoginError extends AccessState {
  final String message;

  LoginError(this.message);
}

final class RegisterError extends AccessState {
  final String message;

  RegisterError(this.message);
}

final class RegisterSuccess extends AccessState {}

final class WaitlistState extends AccessState {}

final class IntraAuthRequired extends AccessState {
  final String message;
  IntraAuthRequired(this.message);
}
