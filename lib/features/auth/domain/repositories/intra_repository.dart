import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/entities/intra_user.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

abstract class IntraRepository {
  Future<Either<Failure, IntraUser>> intraLogin();
  
  Future<Either<Failure, IntraUser>> getIntraUserProfile(String login);
}
