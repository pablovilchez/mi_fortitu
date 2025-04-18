import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../entities/user_entity.dart';
import '../repositories/profiles_repository.dart';


class GetProfileUsecase {
  final ProfilesRepository repository;

  GetProfileUsecase(this.repository);

  Future<Either<HomeFailure, UserEntity>> call(String loginName) async {
    return repository.getIntraProfile(loginName);
  }
}