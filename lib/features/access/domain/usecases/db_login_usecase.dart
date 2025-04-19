import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/domain/entities/db_login_entity.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_db_repository.dart';

class DbLogInUsecase {
  final AccessDbRepository repository;

  DbLogInUsecase(this.repository);

  Future<Either<AccessFailure, DbLoginEntity>> call(String email, String password) async {
    final response = await repository.login(email, password);
    return response;
  }
}
