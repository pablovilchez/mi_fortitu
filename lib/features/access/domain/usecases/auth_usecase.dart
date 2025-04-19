import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_intra_repository.dart';

import '../repositories/access_db_repository.dart';

class AuthUsecase {
  final AccessDbRepository _dbRepository;
  final AccessIntraRepository _intraRepository;

  AuthUsecase(this._dbRepository, this._intraRepository);

  Future<Either<AccessFailure, Unit>> call() async {
    final result = await _dbRepository.getToken();
    return result.fold(
      (failure) => Left(failure),
      (unit) async {
        final intraResult = await _intraRepository.requestToken();
        return intraResult.fold(
          (failure) => Left(failure),
          (unit) => Right(unit),
        );
      },
    );
  }
}
