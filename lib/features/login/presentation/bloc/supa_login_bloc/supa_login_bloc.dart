import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'supa_login_event.dart';

part 'supa_login_state.dart';

class SupaLoginBloc extends Bloc<SupaLoginEvent, SupaLoginState> {
  SupaLoginBloc() : super(SupaLoginInitial()) {
    on<SupaAuthEvent>(_onLogin);
    on<SupaRegisterEvent>(_onSupaRegister);
    on<SupaCheckLoginEvent>(_onSupaCheckLogin);
    on<SupaCheckRolEvent>(_onSupaCheckRol);
    on<SupaToggleFormEvent>(_onSupaToggleForm);
  }

  Future<void> _onLogin(SupaLoginEvent event,
      Emitter<SupaLoginState> emit) async {
    emit(SupaLoginLoading());
  }

  Future<void> _onSupaRegister(SupaRegisterEvent event,
      Emitter<SupaLoginState> emit) async {}

  Future<void> _onSupaCheckLogin(SupaCheckLoginEvent event,
      Emitter<SupaLoginState> emit) async {}

  Future<void> _onSupaCheckRol(SupaCheckRolEvent event,
      Emitter<SupaLoginState> emit) async {
  }

  Future<void> _onSupaToggleForm(SupaToggleFormEvent event,
      Emitter<SupaLoginState> emit) async {
    if (state is SupaLoginRegister) {
      emit(SupaLoginInitial());
    } else {
      emit(SupaLoginRegister());
    }
  }
}
