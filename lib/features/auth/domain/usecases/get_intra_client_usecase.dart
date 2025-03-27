import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/entities/intra_login.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

import 'package:mi_fortitu/features/auth/data/repositories/auth_intra_repository_impl.dart';

import '../repositories/auth_intra_repository.dart';

class GetIntraClientUsecase {
  final AuthIntraRepository repository;

  GetIntraClientUsecase(this.repository);

  Future<Either<Failure, IntraLogin>> call() async {
    return await repository.getIntraClient();
  }
}
