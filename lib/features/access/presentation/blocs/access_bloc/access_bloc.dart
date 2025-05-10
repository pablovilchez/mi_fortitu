import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/access/domain/usecases/get_role_usecase.dart';

import '../../../domain/usecases/usecases.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final AuthUsecase authUsecase;
  final LogInUsecase dbLogInUsecase;
  final RegisterUsecase dbRegisterUsecase;
  final GetRoleUsecase getRoleUseCase;

  AccessBloc(this.authUsecase, this.dbLogInUsecase, this.dbRegisterUsecase, this.getRoleUseCase)
    : super(AccessInitial()) {
    on<LandingEvent>(_onLanding);
    on<RequestDbLoginEvent>(_onRequestDbLogin);
    on<RequestDbRegisterEvent>(_onRequestDbRegister);
    on<ToggleFormEvent>(_onToggleForm);
    on<CheckRolEvent>(_onCheckRol);
  }

  Future<void> _onLanding(LandingEvent event, Emitter<AccessState> emit) async {
    emit(AccessLoading());

    final authenticate = await authUsecase.call();
    authenticate.fold((failure) {
      emit(LoginFormState());
    }, (authenticated) => add(CheckRolEvent()));
  }

  Future<void> _onRequestDbLogin(RequestDbLoginEvent event, Emitter<AccessState> emit) async {
    emit(const AccessLoading());
    final result = await dbLogInUsecase(event.email, event.password);
    result.fold(
      (failure) {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(LoginFormState());
      },
      (_) {
        add(CheckRolEvent());
      },
    );
  }

  Future<void> _onRequestDbRegister(RequestDbRegisterEvent event, Emitter<AccessState> emit) async {
    emit(AccessLoading());
    final result = await dbRegisterUsecase(event.email, event.password);
    result.fold(
      (failure) {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(RegisterFormState());
      },
      (_) {
        emit(AccessFeedbackState(message: tr('access.messages.reg_success')));
        emit(LoginFormState());
      },
    );
  }

  Future<void> _onToggleForm(ToggleFormEvent event, Emitter<AccessState> emit) async {
    if (state is LoginFormState) {
      emit(RegisterFormState());
    } else {
      emit(LoginFormState());
    }
  }

  Future<void> _onCheckRol(CheckRolEvent event, Emitter<AccessState> emit) async {
    emit(AccessLoading());
    final result = await getRoleUseCase.call();
    await result.fold(
      (failure) async {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(WaitlistState());
      },
      (role) async {
        if (role == 'waitlist') {
          emit(WaitlistState());
        } else {
          emit(const Authenticated());
        }
      },
    );
  }
}
