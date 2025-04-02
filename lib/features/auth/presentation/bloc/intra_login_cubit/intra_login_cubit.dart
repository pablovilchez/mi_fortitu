import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/intra_auth_usecase.dart';

part 'intra_login_state.dart';

class IntraLoginCubit extends Cubit<IntraLoginState> {
  final IntraAuthUsecase intraAuthUsecase;

  IntraLoginCubit({required this.intraAuthUsecase})
    : super(IntraLoginInitial());

  Future<void> login() async {
    emit(IntraLoginLoading());
    final response = await intraAuthUsecase.call();
    response.fold(
      (failure) => emit(IntraLoginFailure(failure.message)),
      (_) => emit(IntraLoginSuccess()),
    );
  }
}
