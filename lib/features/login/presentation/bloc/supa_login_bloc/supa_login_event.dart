part of 'supa_login_bloc.dart';

@immutable
sealed class SupaLoginEvent {}

class SupaAuthEvent extends SupaLoginEvent {
  final String email;
  final String password;

  SupaAuthEvent({required this.email, required this.password});
}

class SupaRegisterEvent extends SupaLoginEvent {
  final String email;
  final String password;
  final String loginName;

  SupaRegisterEvent({
    required this.email,
    required this.password,
    required this.loginName,
  });
}

class SupaInitCheckEvent extends SupaLoginEvent {}

class SupaErrorEvent extends SupaLoginEvent {
  final String message;

  SupaErrorEvent(this.message);
}

class SupaCheckRolEvent extends SupaLoginEvent {}

class SupaToggleFormEvent extends SupaLoginEvent {}