import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/data/datasources/home_intra_datasource.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_event_entity.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile_entity.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';
import 'package:mi_fortitu/features/home/domain/repositories/home_intra_repository.dart';

import '../../domain/entities/cluster_user_entity.dart';

class HomeIntraRepositoryImpl implements HomeIntraRepository {
  final HomeIntraDatasource datasource;

  HomeIntraRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, IntraProfileEntity>> getIntraProfile(String loginName) async {
    final response = await datasource.getIntraProfile(loginName: loginName);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (profileModel) => Right(profileModel.toEntity()),
    );
  }

  @override
  Future<Either<HomeFailure, List<IntraEventEntity>>> getIntraUserEvents(String loginName) async {
    final response = await datasource.getIntraUserEvents(loginName: loginName);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<IntraEventEntity>>> getIntraCampusEvents(String campusId) async {
    final response = await datasource.getIntraCampusEvents(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<ClusterUserEntity>>> getIntraClusterUsers(String campusId) async {
    final response = await datasource.getIntraClusterUsers(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
