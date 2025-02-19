import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/features/auth/domain/usecases/usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());

    final result = await _authRepository.authLogin(email, password);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthSuccess()),
    );
  }

  Future<void> register(String email, String password, String displayName) async {
    emit(const AuthLoading());

    final result = await _authRepository.authRegister(email, password, displayName);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthSuccess()),
    );
  }
}