part of 'supa_login_bloc.dart';

@immutable
sealed class SupaLoginEvent {}

class SupaAuthEvent extends SupaLoginEvent {}

class SupaRegisterEvent extends SupaLoginEvent {}

class SupaCheckLoginEvent extends SupaLoginEvent {}

class SupaCheckRolEvent extends SupaLoginEvent {}