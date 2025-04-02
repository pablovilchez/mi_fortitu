import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';

import 'package:mi_fortitu/core/helpers/secure_storage_helper.dart';

class IntraAuthUsecase {
  final AuthIntraRepository repository;
  final SecureStorageHelper secureStorageHelper;

  IntraAuthUsecase(this.repository, this.secureStorageHelper);

  Future<Either<Failure, Unit>> call() async {
    return await repository.requestNewToken();
  }
}
