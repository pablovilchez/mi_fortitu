import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/login/domain/usecases/usecases.dart';

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

  Future<void> _onLanding(LandingEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());

    final result = await CheckProfileCredentialsUsecase().call();
    result.fold(
      (failure) => emit(LoginFormState()),
      (supaLogin) => add(CheckRolEvent()),
    );
  }

  Future<void> _onRequestLogin(
    RequestLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingState());
    final result = await LoginUsecase().call(event.email, event.password);
    result.fold(
      (failure) {
        emit(LoginError(failure.message));
        emit(LoginFormState());
      },
      (supaLogin) {
        add(CheckRolEvent());
      },
    );
  }

  Future<void> _onRequestRegister(
    RequestRegisterEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingState());
    final result = await RegisterUsecase().call(event.email, event.password);
    result.fold((failure) {
      emit(RegisterError(failure.message));
      emit(RegisterFormState());
    }, (supaLogin) {
      emit(RegisterSuccess());
      emit(LoginFormState());
    });
  }

  Future<void> _onCheckRol(
    CheckRolEvent event,
    Emitter<LoginState> emit,
  ) async {
    final role = await GetRoleUseCase().call();
    role.fold(
      (failure) => emit(LoginError(failure.message)),
      (role) {
        if (role == 'waitlist') {
          emit(WaitlistState());
        } else if (role == 'npc') {
          emit(LoginSuccess());
        } else {
          add(CheckIntraAuthEvent());
        }
      },
    );
  }

  Future<void> _onCheckIntraAuth(
    CheckIntraAuthEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoadingState());
    final result = await GetIntraClientUsecase().call();
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (supaLogin) => emit(LoginSuccess()),
    );
  }

  Future<void> _onToggleForm(
    ToggleFormEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (state is LoginFormState) {
      emit(RegisterFormState());
    } else {
      emit(LoginFormState());
    }
  }
}
