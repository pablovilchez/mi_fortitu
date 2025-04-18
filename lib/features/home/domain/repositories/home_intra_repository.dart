import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/failures.dart';
import 'package:mi_fortitu/features/home/domain/entities/event_entity.dart';
import 'package:mi_fortitu/features/home/domain/entities/user_entity.dart';

import '../entities/location_entity.dart';
import '../entities/bloc_entity.dart';
import '../entities/project_user_entity.dart';

abstract class HomeIntraRepository {
  Future<Either<HomeFailure,UserEntity>> getIntraProfile(String loginName);

  Future<Either<HomeFailure,List<EventEntity>>> getIntraUserEvents(String loginName);

  Future<Either<HomeFailure,List<EventEntity>>> getIntraCampusEvents(String campusId);

  Future<Either<HomeFailure,List<LocationEntity>>> getIntraClusterUsers(String campusId);

  Future<Either<HomeFailure, List<BlocEntity>>> getCampusCoalitions(String campusId);

  Future<Either<HomeFailure, List<ProjectUserEntity>>> getProjectUsers(String projectId, String campusId);
}
