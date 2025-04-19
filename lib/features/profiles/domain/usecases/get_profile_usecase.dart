import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../profiles_failure.dart';
import '../repositories/profiles_repository.dart';


class GetProfileUsecase {
  final ProfilesRepository repository;

  GetProfileUsecase(this.repository);

  Future<Either<ProfilesFailure, UserEntity>> call(String loginName) async {
    return repository.getIntraProfile(loginName);
  }
}