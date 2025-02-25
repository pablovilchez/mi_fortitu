import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/login/domain/entities/supa_login.dart';
import 'package:mi_fortitu/features/login/domain/failures.dart';
import 'package:mi_fortitu/features/login/data/repositories/supa_login_repository.dart';

class LoginAuthUsecase {
  final SupaLoginRepository repository;

  LoginAuthUsecase(this.repository);

  Future<Either<Failure, SupaLogin>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
