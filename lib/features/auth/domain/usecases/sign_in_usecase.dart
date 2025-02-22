import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/entities/auth_user.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository repository;

  SignInUsecase(this.repository);

  Future<Either<Failure, AuthUser>> call(String email, String password) async {
    return await repository.authSignIn(email, password);
  }
}