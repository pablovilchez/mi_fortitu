import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../profiles_failure.dart';

abstract class ProfilesRepository {
  Future<Either<ProfilesFailure,UserEntity>> getIntraProfile(String loginName);
}