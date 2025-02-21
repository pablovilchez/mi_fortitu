import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class CheckApprovalUsecase {
  final AuthRepository _authRepository;

  CheckApprovalUsecase(this._authRepository);

  Future<Either<Failure, bool>> call() async {
    return await _authRepository.checkApproval();
  }
}