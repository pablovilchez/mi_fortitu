part of 'supa_login_bloc.dart';

@immutable
sealed class SupaLoginState {}

final class SupaLoginInitial extends SupaLoginState {}

final class SupaLoginLoading extends SupaLoginState {}

final class SupaLoginSuccess extends SupaLoginState {}

final class SupaLoginFailure extends SupaLoginState {
  final String message;

  SupaLoginFailure(this.message);
}

final class SupaLoginError extends SupaLoginState {}

final class SupaLoginRegister extends SupaLoginState {}

final class SupaLoginWaitlist extends SupaLoginState {}

final class SupaLoginHome extends SupaLoginState {}