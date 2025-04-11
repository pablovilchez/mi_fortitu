import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/entities/db_login_entity.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_db_repository.dart';

class DbLogInUsecase {
  final AuthDbRepository repository;

  DbLogInUsecase(this.repository);

  Future<Either<Failure, DbLoginEntity>> call(String email, String password) async {
    final response = await repository.login(email, password);
    return response.fold(
      (exception) => Left(AuthFailure(exception.message)),
      (model) => Right(model),
    );
  }
}
