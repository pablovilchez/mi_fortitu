import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/login/domain/failures.dart';

import '../../data/repositories/supa_login_repository.dart';

class AddProfileUseCase {
  final repository = SupaLoginRepository();

  Future<Either<Failure, Unit>> call() async {
    return await repository.addProfile();
  }
}