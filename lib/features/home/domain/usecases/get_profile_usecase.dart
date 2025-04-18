import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../entities/user_entity.dart';
import '../repositories/home_intra_repository.dart';

class GetProfileUsecase {
  final HomeIntraRepository repository;

  GetProfileUsecase({required this.repository});

  Future<Either<HomeFailure, UserEntity>> call(String loginName) async {
    return repository.getIntraProfile(loginName);
  }
}