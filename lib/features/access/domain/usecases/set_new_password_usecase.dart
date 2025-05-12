import 'package:dartz/dartz.dart';

import '../access_failure.dart';
import '../repositories/access_repository.dart';

class SetNewPasswordUsecase {
  final AccessRepository _authRepository;

  SetNewPasswordUsecase(this._authRepository);

  Future<Either<AccessFailure, Unit>> call(String newPassword) async {
    return await _authRepository.setNewPassword(newPassword);
  }
}
