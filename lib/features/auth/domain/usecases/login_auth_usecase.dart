import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/entities/auth_user.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class LoginAuthUsecase {
  final AuthRepository repository;

  LoginAuthUsecase(this.repository);

  Future<Either<Failure, AuthUser>> call(String email, String password) async {
    return await repository.authLogin(email, password);
  }
}
