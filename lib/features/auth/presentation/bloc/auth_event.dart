part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  const AuthRegister(this.email, this.password, this.displayName);

  @override
  List<Object?> get props => [email, password, displayName];
}

class AuthCheckTokens extends AuthEvent {
  const AuthCheckTokens();
}

class AuthCheckApproval extends AuthEvent {
  const AuthCheckApproval();
}
