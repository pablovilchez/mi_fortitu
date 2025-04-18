import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/data/datasources/home_intra_datasource.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';
import 'package:mi_fortitu/features/home/domain/repositories/home_intra_repository.dart';

import 'package:mi_fortitu/features/home/domain/entities/entities.dart';

class HomeIntraRepositoryImpl implements HomeIntraRepository {
  final HomeIntraDatasource datasource;

  HomeIntraRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, UserEntity>> getIntraProfile(String loginName) async {
    final response = await datasource.getUser(loginName: loginName);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (profileModel) => Right(profileModel.toEntity()),
    );
  }

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getIntraUserEvents(String loginName) async {
    final response = await datasource.getUserEvents(loginName: loginName);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getIntraCampusEvents(String campusId) async {
    final response = await datasource.getCampusEvents(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<LocationEntity>>> getIntraClusterUsers(String campusId) async {
    final response = await datasource.getCampusLocations(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<BlocEntity>>> getCampusCoalitions(String campusId) async {
    final response = await datasource.getCampusBlocs(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (campus) => Right(campus.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<ProjectUserEntity>>> getProjectUsers(String projectId, String campusId) async {
    final response = await datasource.getProjectUsers(projectId: projectId, campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
