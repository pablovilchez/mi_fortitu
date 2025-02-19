part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class Authenticated extends AuthState {
  const Authenticated();
}