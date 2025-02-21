import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class CheckTokensUsecase {
  final AuthRepository _authRepository;

  CheckTokensUsecase(this._authRepository);

  Future<Either<Failure, void>> call() async {
    return await _authRepository.authCheck();
  }
}