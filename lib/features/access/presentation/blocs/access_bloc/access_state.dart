part of 'access_bloc.dart';

sealed class AccessState {
  final String? message;
  final bool isError;

  const AccessState({this.message, this.isError = false});
}

class AccessFeedbackState extends AccessState {
  const AccessFeedbackState({required super.message, super.isError = false});
}

class AccessInitial extends AccessState {
  const AccessInitial();
}

class AccessLoading extends AccessState {
  const AccessLoading();
}

class LoginFormState extends AccessState {
  const LoginFormState();
}

class RegisterFormState extends AccessState {
  const RegisterFormState();
}

class RequestRecoveryEmailFormState extends AccessState {
  const RequestRecoveryEmailFormState();
}

class Authenticated extends AccessState {
  const Authenticated();
}

class WaitlistState extends AccessState {
  const WaitlistState();
}
