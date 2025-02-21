part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
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

class AuthNotAuthenticated extends AuthState {
  const AuthNotAuthenticated();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

class AuthApproved extends AuthState {
  const AuthApproved();
}

class AuthPendingApproval extends AuthState {
  const AuthPendingApproval();
}
