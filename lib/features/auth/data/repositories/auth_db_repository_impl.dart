import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_supa_datasource.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_db_repository.dart';

import '../../domain/entities/db_login_entity.dart';

class AuthDbRepositoryImpl implements AuthDbRepository {
  final AuthSupaDatasource datasource;

  AuthDbRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, DbLoginEntity>> login(String email, String password) async {
    final response = await datasource.login(email, password);
    return response
        .leftMap((exception) => AuthFailure(exception.message))
        .map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, DbLoginEntity>> register(String email, String password) async {
    final response = await datasource.register(email, password);
    return response
        .leftMap((exception) => AuthFailure(exception.message))
        .map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> getToken() async {
    final response = await datasource.checkDbUserAuth();
    return response.leftMap((exception) => AuthFailure(exception.message));
  }

  @override
  Future<Either<Failure, String>> getRole() async {
    final responseGet = await datasource.getRole();
    final mappedResponse = responseGet.leftMap((exception) => DatabaseFailure(exception.message));

    if (responseGet.isLeft()) {
      final responseAdd = await datasource.addProfile();
      return responseAdd.leftMap((exception) => DatabaseFailure(exception.message));
    } else {
      return mappedResponse;
    }
  }
}
