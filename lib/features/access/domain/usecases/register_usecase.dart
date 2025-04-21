import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/domain/entities/login_entity.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_repository.dart';

class RegisterUsecase {
  final AccessRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<AccessFailure, LoginEntity>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
