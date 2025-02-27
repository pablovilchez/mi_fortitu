import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/login/data/repositories/supa_login_repository.dart';
import 'package:mi_fortitu/features/login/domain/entities/supa_login.dart';
import 'package:mi_fortitu/features/login/domain/failures.dart';

class RegisterUsecase {
  final repository = SupaLoginRepository();

  Future<Either<Failure, SupaLogin>> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
