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
  final String confirmPassword;

  SupaRegisterEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SupaCheckLoginEvent extends SupaLoginEvent {}

class SupaCheckRolEvent extends SupaLoginEvent {}

class SupaToggleFormEvent extends SupaLoginEvent {}