import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String email, String password) async {
    return await repository.authLogin(email, password);
  }
}
