import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/usecases.dart';

part 'supa_login_event.dart';
part 'supa_login_state.dart';

class SupaLoginBloc extends Bloc<SupaLoginEvent, SupaLoginState> {
  final GetIntraClientUsecase intraGetClient;
  final GetRoleUseCase getRoleUseCase;
  final LogInUsecase logInUsecase;
  final RegisterUsecase registerUsecase;
  final CheckProfileCredentialsUsecase checkProfileCredentialsUsecase;

  SupaLoginBloc({
    required this.intraGetClient,
    required this.getRoleUseCase,
    required this.logInUsecase,
    required this.registerUsecase,
    required this.checkProfileCredentialsUsecase,
  }) : super(LandingState()) {
    on<LandingEvent>(_onLanding);
    on<RequestLoginEvent>(_onRequestLogin);
    on<RequestRegisterEvent>(_onRequestRegister);
    on<CheckIntraAuthEvent>(_onCheckIntraAuth);
    on<CheckRolEvent>(_onCheckRol);
    on<ToggleFormEvent>(_onToggleForm);
  }

  Future<void> _onLanding(LandingEvent event, Emitter<SupaLoginState> emit) async {
    emit(LoadingState());

    final result = await checkProfileCredentialsUsecase();
    result.fold((failure) => emit(LoginFormState()), (supaLogin) => add(CheckRolEvent()));
  }

  Future<void> _onRequestLogin(RequestLoginEvent event, Emitter<SupaLoginState> emit) async {
    emit(LoadingState());
    final result = await logInUsecase(event.email, event.password);
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

  Future<void> _onRequestRegister(RequestRegisterEvent event, Emitter<SupaLoginState> emit) async {
    emit(LoadingState());
    final result = await registerUsecase(event.email, event.password);
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

  Future<void> _onCheckRol(CheckRolEvent event, Emitter<SupaLoginState> emit) async {
    final role = await getRoleUseCase();
    role.fold((failure) => emit(LoginError(failure.message)), (role) {
      if (role == 'waitlist') {
        emit(WaitlistState());
      } else if (role == 'npc') {
        emit(LoginSuccess());
      } else {
        add(CheckIntraAuthEvent());
      }
    });
  }

  Future<void> _onCheckIntraAuth(CheckIntraAuthEvent event, Emitter<SupaLoginState> emit) async {
    emit(LoadingState());
    final result = await intraGetClient();
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (supaLogin) => emit(LoginSuccess()),
    );
  }

  Future<void> _onToggleForm(ToggleFormEvent event, Emitter<SupaLoginState> emit) async {
    if (state is LoginFormState) {
      emit(RegisterFormState());
    } else {
      emit(LoginFormState());
    }
  }
}
