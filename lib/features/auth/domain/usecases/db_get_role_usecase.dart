import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_db_repository.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';

class GetRoleUsecase {
  final AuthDbRepository _authDbRepository;

  GetRoleUsecase(this._authDbRepository);

  Future<Either<Failure, String>> call() async {
    return await _authDbRepository.getRole();
  }
}