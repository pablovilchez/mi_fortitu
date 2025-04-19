import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/domain/entities/db_login_entity.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_db_repository.dart';

class DbRegisterUsecase {
  final AccessDbRepository repository;

  DbRegisterUsecase(this.repository);

  Future<Either<AccessFailure, DbLoginEntity>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
