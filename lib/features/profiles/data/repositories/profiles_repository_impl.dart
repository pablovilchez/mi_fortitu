import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/profiles/data/datasources/profiles_datasource.dart';

import '../../../home/domain/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profiles_repository.dart';

class ProfilesRepositoryImpl extends ProfilesRepository {
  final ProfilesDatasource datasource;

  ProfilesRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, UserEntity>> getIntraProfile(String loginName) async {
    final response = await datasource.getUser(loginName: loginName);
    return response.fold(
          (exception) => Left(AuthFailure(exception.toString())),
          (profileModel) => Right(profileModel.toEntity()),
    );
  }
}