import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/access/domain/access_failure.dart';

import '../repositories/access_repository.dart';

class AuthUsecase {
  final AccessRepository _repository;

  AuthUsecase(this._repository);

  Future<Either<AccessFailure, Unit>> call() async {
    return await _repository.getToken();
  }
}
