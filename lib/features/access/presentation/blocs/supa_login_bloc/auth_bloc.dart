import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/access/domain/usecases/db_get_role_usecase.dart';

import '../../../domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  final DbLogInUsecase dbLogInUsecase;
  final DbRegisterUsecase dbRegisterUsecase;
  final GetRoleUsecase getRoleUseCase;

  AuthBloc(this.authUsecase, this.dbLogInUsecase, this.dbRegisterUsecase, this.getRoleUseCase)
    : super(LandingState()) {
    on<LandingEvent>(_onLanding);
    on<RequestDbLoginEvent>(_onRequestDbLogin);
    on<RequestDbRegisterEvent>(_onRequestDbRegister);
    on<ToggleFormEvent>(_onToggleForm);
    on<CheckRolEvent>(_onCheckRol);
  }

  Future<void> _onLanding(LandingEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    final authenticate = await authUsecase.call();
    authenticate.fold((failure) {
      emit(LoginFormState());
    }, (authenticated) => add(CheckRolEvent()));
  }

  Future<void> _onRequestDbLogin(RequestDbLoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    final result = await dbLogInUsecase(event.email, event.password);
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

  Future<void> _onRequestDbRegister(RequestDbRegisterEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    final result = await dbRegisterUsecase(event.email, event.password);
    result.fold(
      (failure) {
        emit(RegisterError(failure.message));
        emit(RegisterFormState());
      },
      (supaLogin) {
        emit(RegisterSuccess());
        emit(LoginFormState());
      },
    );
  }

  Future<void> _onToggleForm(ToggleFormEvent event, Emitter<AuthState> emit) async {
    if (state is LoginFormState) {
      emit(RegisterFormState());
    } else {
      emit(LoginFormState());
    }
  }

  Future<void> _onCheckRol(CheckRolEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    final result = await getRoleUseCase.call();
    result.fold(
      (failure) {
        emit(LoginError(failure.message));
        emit(WaitlistState());
      },
      (role) {
        if (role == 'waitlist') {
          emit(WaitlistState());
        } else {
          emit(LoginSuccess());
        }
      },
    );
  }
}
