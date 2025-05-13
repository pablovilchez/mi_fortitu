import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/access/access.dart';

part 'access_event.dart';
part 'access_state.dart';

/// AccessBloc is responsible for managing the authentication and registration
/// processes in the application.
/// It handles events related to login, registration, password recovery,
/// and role checking.
class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final AuthUsecase authUsecase;
  final LogInUsecase logInUsecase;
  final RegisterUsecase registerUsecase;
  final RequestAccountRecoveryEmailUsecase recoveryEmailUsecase;
  final SetNewPasswordUsecase setNewPasswordUsecase;
  final GetRoleUsecase getRoleUseCase;

  AccessBloc(
    this.authUsecase,
    this.logInUsecase,
    this.registerUsecase,
    this.getRoleUseCase,
    this.recoveryEmailUsecase,
    this.setNewPasswordUsecase,
  ) : super(const AccessInitial()) {
    on<LandingEvent>(_onLanding);
    on<ShowLoginFormEvent>((event, emit) => emit(const LoginFormState()));
    on<ShowRegisterFormEvent>((event, emit) => emit(const RegisterFormState()));
    on<ShowResetPasswordFormEvent>((event, emit) => emit(const RequestRecoveryEmailFormState()));
    on<RequestDbLoginEvent>(_onRequestDbLogin);
    on<RequestDbRegisterEvent>(_onRequestDbRegister);
    on<RequestDbRecoveryEmailEvent>(_onRequestDbRecoveryEmail);
    on<RequestSetNewPasswordEvent>(_onRequestSetNewPassword);
    on<ToggleFormEvent>(_onToggleForm);
    on<CheckRolEvent>(_onCheckRol);
  }

  /// Handles the initial landing event.
  /// It checks if the user is authenticated and emits the appropriate state.
  Future<void> _onLanding(LandingEvent event, Emitter<AccessState> emit) async {
    emit(const AccessLoading());

    final authenticate = await authUsecase.call();
    authenticate.fold((failure) {
      emit(const LoginFormState());
    }, (authenticated) => add(CheckRolEvent()));
  }

  /// Handles the login form event of the database.
  Future<void> _onRequestDbLogin(RequestDbLoginEvent event, Emitter<AccessState> emit) async {
    emit(const AccessLoading());
    final result = await logInUsecase(event.email, event.password);
    result.fold(
      (failure) {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(const LoginFormState());
      },
      (_) {
        add(CheckRolEvent());
      },
    );
  }

  /// Handles the registration form event of the database.
  Future<void> _onRequestDbRegister(RequestDbRegisterEvent event, Emitter<AccessState> emit) async {
    emit(const AccessLoading());
    final result = await registerUsecase(event.email, event.password);
    result.fold(
      (failure) {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(const RegisterFormState());
      },
      (_) {
        emit(AccessFeedbackState(message: tr('access.message.reg_request_success')));
        emit(const LoginFormState());
      },
    );
  }

  /// Handles the request for a password recovery email.
  Future<void> _onRequestDbRecoveryEmail(
    RequestDbRecoveryEmailEvent event,
    Emitter<AccessState> emit,
  ) async {
    emit(const AccessLoading());
    final result = await recoveryEmailUsecase(event.email);
    result.fold(
      (failure) {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(const LoginFormState());
      },
      (_) {
        emit(AccessFeedbackState(message: tr('access.message.pass_request_success')));
        emit(const LoginFormState());
      },
    );
  }

  /// Handles the request to set a new password.
  Future<void> _onRequestSetNewPassword(
    RequestSetNewPasswordEvent event,
    Emitter<AccessState> emit,
  ) async {
    emit(const AccessLoading());
    final result = await setNewPasswordUsecase(event.newPassword);
    result.fold(
      (failure) {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(const RequestRecoveryEmailFormState());
      },
      (_) {
        emit(AccessFeedbackState(message: tr('access.message.pass_change_success')));
        add(CheckRolEvent());
      },
    );
  }

  /// Toggles between the login and registration forms.
  Future<void> _onToggleForm(ToggleFormEvent event, Emitter<AccessState> emit) async {
    if (state is LoginFormState) {
      emit(const RegisterFormState());
    } else {
      emit(const LoginFormState());
    }
  }

  /// Checks the role of the user and emits the appropriate state.
  Future<void> _onCheckRol(CheckRolEvent event, Emitter<AccessState> emit) async {
    emit(const AccessLoading());
    final result = await getRoleUseCase.call();
    await result.fold(
      (failure) async {
        emit(AccessFeedbackState(message: failure.message, isError: true));
        emit(const WaitlistState());
      },
      (role) async {
        if (role == 'waitlist') {
          emit(const WaitlistState());
        } else {
          emit(const Authenticated());
        }
      },
    );
  }
}
