import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/domain/entities/login_entity.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_repository.dart';

class LogInUsecase {
  final AccessRepository repository;

  LogInUsecase(this.repository);

  Future<Either<AccessFailure, LoginEntity>> call(String email, String password) async {
    final response = await repository.login(email, password);
    return response;
  }
}
