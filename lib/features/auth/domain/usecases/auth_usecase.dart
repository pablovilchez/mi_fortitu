import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';

import '../repositories/auth_db_repository.dart';

class AuthUsecase {
  final AuthDbRepository _dbRepository;
  final AuthIntraRepository _intraRepository;

  AuthUsecase(this._dbRepository, this._intraRepository);

  Future<Either<Failure, Unit>> call() async {
    final result = await _dbRepository.getToken();
    return result.fold(
      (failure) => Left(DbTokenFailure(failure.message)),
      (unit) async {
        final intraResult = await _intraRepository.requestToken();
        return intraResult.fold(
          (failure) => Left(IntraTokenFailure(failure.message)),
          (unit) => Right(unit),
        );
      },
    );
  }
}
