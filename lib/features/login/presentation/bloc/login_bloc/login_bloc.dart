import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/login/domain/usecases/check_credentials_usecase.dart';
import 'package:mi_fortitu/features/login/domain/usecases/get_role_usecase.dart';
import 'package:mi_fortitu/features/login/domain/usecases/login_usecase.dart';

import 'package:mi_fortitu/features/login/domain/usecases/register_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LandingState()) {
    on<LandingEvent>(_onLanding);
    on<RequestLoginEvent>(_onRequestLogin);
    on<RequestRegisterEvent>(_onRequestRegister);
    on<CheckIntraAuthEvent>(_onCheckIntraAuth);
    on<CheckRolEvent>(_onCheckRol);
    on<ToggleFormEvent>(_onToggleForm);
  }

  Future<void> _onLanding(LandingEvent event,
      Emitter<LoginState> emit) async {
    emit(LoadingState());

    final result = await CheckCredentialsUsecase().call();
    result.fold(
      (failure) => emit(LoginFormState()),
      (supaLogin) => emit(LoginSuccess()),
    );
  }

  Future<void> _onRequestLogin(RequestLoginEvent event,
      Emitter<LoginState> emit) async {
    emit(LoadingState());
    final result = await LoginUsecase().call(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(RequestError(failure.message)),
      (supaLogin) => add(CheckIntraAuthEvent()),
    );
  }

  Future<void> _onRequestRegister(RequestRegisterEvent event,
      Emitter<LoginState> emit) async {
    emit(LoadingState());
    final result = await RegisterUsecase().call(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(RequestError(failure.message)),
      (supaLogin) => emit(RegisterSuccess()),
    );
  }

  Future<void> _onCheckIntraAuth(CheckIntraAuthEvent event,
      Emitter<LoginState> emit) async {
    emit(LoadingState());
    final result = await CheckCredentialsUsecase().call();
    result.fold(
      (failure) => emit(LoginFormState()),
      (supaLogin) => add(CheckRolEvent()),
    );
  }

  Future<void> _onCheckRol(CheckRolEvent event,
      Emitter<LoginState> emit) async {
    final role = await GetRoleUseCase().call();
    role.fold(
      (failure) => add(AddProfileEvent()),
      (role) {
        if (role == 'waitlist') {
          emit(WaitlistState());
        } else {
          emit(LoginSuccess());
        }
      },
    );
  }

  Future<void> _onToggleForm(ToggleFormEvent event,
      Emitter<LoginState> emit) async {
    if (state is LoginFormState || state is RequestError) {
      emit(RegisterFormState());
    } else {
      emit(LoginFormState());
    }
  }
}
