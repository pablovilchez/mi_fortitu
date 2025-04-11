import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/entities/db_login_entity.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_db_repository.dart';

class DbRegisterUsecase {
  final AuthDbRepository repository;

  DbRegisterUsecase(this.repository);

  Future<Either<Failure, DbLoginEntity>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
