import 'package:dartz/dartz.dart';

import'package:mi_fortitu/features/auth/data/repositories/auth_supa_repository_impl.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_supa_repository.dart';

class GetRoleUseCase {
  final AuthSupaRepository repository;

  GetRoleUseCase(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getRole();
  }
}
