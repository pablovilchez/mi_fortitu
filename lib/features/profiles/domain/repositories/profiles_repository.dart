import 'package:dartz/dartz.dart';

import '../../../home/domain/failures.dart';
import '../entities/user_entity.dart';

abstract class ProfilesRepository {
  Future<Either<HomeFailure,UserEntity>> getIntraProfile(String loginName);
}