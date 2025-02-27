import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/login/domain/usecases/check_credentials_usecase.dart';
import 'package:mi_fortitu/features/login/domain/usecases/get_role_usecase.dart';
import 'package:mi_fortitu/features/login/domain/usecases/login_usecase.dart';

import 'package:mi_fortitu/features/login/domain/usecases/register_usecase.dart';

part 'supa_login_event.dart';

part 'supa_login_state.dart';

class SupaLoginBloc extends Bloc<SupaLoginEvent, SupaLoginState> {
  SupaLoginBloc() : super(SupaLoginInitial()) {
    on<SupaAuthEvent>(_onLogin);
    on<SupaRegisterEvent>(_onSupaRegister);
    on<SupaInitCheckEvent>(_onInitCheck);
    on<SupaErrorEvent>(_onSupaError);
    on<SupaCheckRolEvent>(_onSupaCheckRol);
    on<SupaToggleFormEvent>(_onSupaToggleForm);
  }

  Future<void> _onLogin(SupaAuthEvent event,
      Emitter<SupaLoginState> emit) async {
    emit(SupaLoginLoading());
    final result = await LoginUsecase().call(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(SupaLoginFailure(failure.message)),
      (supaLogin) {
        add(SupaCheckRolEvent());
      },
    );
  }

  Future<void> _onSupaRegister(SupaRegisterEvent event,
      Emitter<SupaLoginState> emit) async {
    emit(SupaLoginLoading());
    final result = await RegisterUsecase().call(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(SupaLoginFailure(failure.message)),
      (supaLogin) => emit(SupaLoginInitial()),
    );
  }

  Future<void> _onInitCheck(SupaInitCheckEvent event,
      Emitter<SupaLoginState> emit) async {
    emit(SupaLoginLoading());

    print('Paso 2: SupaLoginBloc _onInitCheck');
    final result = await CheckCredentialsUsecase().call();

    result.fold(
          (failure) => emit(SupaLoginInitial()),
          (supaLogin) => emit(SupaLoginSuccess()),
    );
  }

  Future<void> _onSupaError(SupaErrorEvent event,
      Emitter<SupaLoginState> emit) async {
    emit(SupaLoginFailure(event.message));
  }

  Future<void> _onSupaCheckRol(SupaCheckRolEvent event,
      Emitter<SupaLoginState> emit) async {
    print('Paso 4: SupaLoginBloc _onSupaCheckRol');
    final role = await GetRoleUseCase().call();
    role.fold(
      (failure) => emit(SupaLoginFailure(failure.message)),
      (role) {
        if (role == 'waitlist') {
          emit(SupaLoginWaitlist());
        } else {
          emit(SupaLoginSuccess());
        }
      },
    );
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
