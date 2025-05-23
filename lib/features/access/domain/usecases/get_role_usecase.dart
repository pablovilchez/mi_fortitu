import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_repository.dart';

import 'package:mi_fortitu/features/access/domain/access_failure.dart';

class GetRoleUsecase {
  final AccessRepository _authDbRepository;

  GetRoleUsecase(this._authDbRepository);

  Future<Either<AccessFailure, String>> call() async {
    return await _authDbRepository.getRole();
  }
}