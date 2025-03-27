import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/data/repositories/auth_supa_repository_impl.dart';
import 'package:mi_fortitu/features/auth/domain/entities/supa_login.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_supa_repository.dart';

class RegisterUsecase {
  final AuthSupaRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, SupaLogin>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
