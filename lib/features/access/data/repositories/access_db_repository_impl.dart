import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/data/datasources/access_supa_datasource.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_db_repository.dart';

import '../../domain/entities/db_login_entity.dart';

class AccessDbRepositoryImpl implements AccessDbRepository {
  final AccessSupaDatasource datasource;

  AccessDbRepositoryImpl(this.datasource);

  @override
  Future<Either<AccessFailure, DbLoginEntity>> login(String email, String password) async {
    final response = await datasource.login(email, password);
    return response
        .leftMap((exception) => DbLoginFailure(exception.code))
        .map((model) => model.toEntity());
  }

  @override
  Future<Either<AccessFailure, DbLoginEntity>> register(String email, String password) async {
    final response = await datasource.register(email, password);
    return response
        .leftMap((exception) => RegisterFailure(exception.code))
        .map((model) => model.toEntity());
  }

  @override
  Future<Either<AccessFailure, Unit>> getToken() async {
    final response = await datasource.checkAuth();
    return response.leftMap((exception) => CredentialsFailure(exception.code));
  }

  @override
  Future<Either<AccessFailure, String>> getRole() async {
    final responseGet = await datasource.getRole();
    final mappedResponse = responseGet.leftMap((exception) => DatabaseFailure(exception.code));

    if (responseGet.isLeft()) {
      final responseAdd = await datasource.addProfile();
      return responseAdd.leftMap((exception) => DatabaseFailure(exception.code));
    } else {
      return mappedResponse;
    }
  }
}
