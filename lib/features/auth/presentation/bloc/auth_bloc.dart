import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mi_fortitu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  bool isIntraLoggedIn = false;

  AuthBloc() : super(const AuthInitial()) {
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthCheckTokens>(_onCheckTokens);
    on<AuthCheckApproval>(_onCheckApproval);
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await LoginUsecase(
      authRepository,
    ).call(event.email, event.password);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => add(const AuthCheckApproval()),
    );
  }

  Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await RegisterUsecase(
      authRepository,
    ).call(event.email, event.password, event.displayName);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthPendingApproval()),
    );
  }

  Future<void> _onCheckTokens(
    AuthCheckTokens event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await CheckTokensUsecase(authRepository).call();

    result.fold(
      (failure) => emit(const AuthNotAuthenticated()),
      (_) => add(const AuthCheckApproval()),
    );
  }

  Future<void> _onCheckApproval(
    AuthCheckApproval event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await CheckApprovalUsecase(authRepository).call();

    result.fold(
      (failure) => emit(const AuthNotAuthenticated()),
      (response) =>
          response
              ? emit(const AuthApproved())
              : emit(const AuthPendingApproval()),
    );
  }
}
