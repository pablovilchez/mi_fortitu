import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/profiles/data/datasources/profiles_datasource.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/profiles_failure.dart';
import '../../domain/repositories/profiles_repository.dart';

class ProfilesRepositoryImpl extends ProfilesRepository {
  final ProfilesDatasource datasource;

  ProfilesRepositoryImpl(this.datasource);

  @override
  Future<Either<ProfilesFailure, UserEntity>> getIntraProfile(String loginName) async {
    final response = await datasource.getUser(loginName: loginName);
    return response.fold(
          (exception) => Left(DataFailure(exception.toString())),
          (profileModel) => Right(profileModel.toEntity()),
    );
  }
}