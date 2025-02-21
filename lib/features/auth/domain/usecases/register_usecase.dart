import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String email, String password, String displayName) async {
    return await repository.authRegister(email, password, displayName);
  }
}