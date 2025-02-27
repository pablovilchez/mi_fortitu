import 'package:dartz/dartz.dart';

import'package:mi_fortitu/features/login/data/repositories/supa_login_repository.dart';

import 'package:mi_fortitu/features/login/domain/failures.dart';

class GetRoleUseCase {
  final repository = SupaLoginRepository();

  Future<Either<Failure, String>> call() async {
    return await repository.getRole();
  }
}
