import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:mi_fortitu/core/utils/secure_storage_helper.dart';

import '../../../domain/usecases/get_intra_client_usecase.dart';

part 'intra_login_state.dart';

class IntraLoginCubit extends Cubit<IntraLoginState> {
  final intraGetClient = GetIntraClientUsecase();

  IntraLoginCubit() : super(IntraLoginInitial()) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await SecureStorageHelper.getIntraAccessToken();
    if (token != null) {
      emit(IntraLoginSuccess());
    } else {
      emit(IntraLoginInitial());
    }
  }

  Future<void> login() async {
    emit(IntraLoginLoading());
    final result = await intraGetClient.call();
    result.fold(
      (failure) => emit(IntraLoginFailure(failure.message)),
      (_) => emit(IntraLoginSuccess()),
    );
  }

  Future<void> logout() async {
    await SecureStorageHelper.deleteIntraTokens();
    emit(IntraLoginInitial());
  }
}
