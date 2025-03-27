import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/data/repositories/auth_supa_repository_impl.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

import '../repositories/auth_supa_repository.dart';

class CheckProfileCredentialsUsecase {
  final AuthSupaRepository repository;

  CheckProfileCredentialsUsecase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.checkProfileCredentials();
  }
}
