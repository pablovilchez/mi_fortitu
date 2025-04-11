import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/failures.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_event_entity.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile_entity.dart';

import '../entities/cluster_user_entity.dart';

abstract class HomeIntraRepository {
  Future<Either<HomeFailure,IntraProfileEntity>> getIntraProfile(String loginName);

  Future<Either<HomeFailure,List<IntraEventEntity>>> getIntraUserEvents(String loginName);

  Future<Either<HomeFailure,List<IntraEventEntity>>> getIntraCampusEvents(String campusId);

  Future<Either<HomeFailure,List<ClusterUserEntity>>> getIntraClusterUsers(String campusId);
}
