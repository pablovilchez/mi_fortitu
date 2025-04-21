import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/core/services/intra_api_client.dart';

import '../repositories/settings_repository.dart';
import '../settings_failure.dart';

class LogoutUsecase {
  final SettingsRepository _authRepository;
  final IntraApiClient _intraApiClient;

  LogoutUsecase(this._authRepository, this._intraApiClient);

  Future<Either<SettingsFailure, Unit>> call() async {
    final supaLogoutResult = await _authRepository.logoutDatabase();
    if (supaLogoutResult.isLeft()) return supaLogoutResult;

    final intraLogoutResult = await _intraApiClient.logoutIntra();
    return intraLogoutResult.fold(
          (exception) => Left(LogoutFailure(exception.toString())),
          (_) => Right(unit),
    );
  }
}