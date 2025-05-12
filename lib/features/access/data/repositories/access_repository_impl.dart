import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/data/datasources/access_datasource.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_repository.dart';

import '../../domain/entities/login_entity.dart';

/// Repository class for handling authentication and user profile operations
///
/// This class provides methods for logging in, registering, recovering password,
/// checking authentication, retrieving user roles, and adding user profiles.
class AccessRepositoryImpl implements AccessRepository {
  final AccessDatasource datasource;

  AccessRepositoryImpl(this.datasource);

  /// Logs in a user with the provided email and password.
  ///
  /// Returns a [Either] containing either an [AccessFailure] or a [LoginEntity].
  @override
  Future<Either<AccessFailure, LoginEntity>> login(String email, String password) async {
    final response = await datasource.login(email, password);
    return response
        .leftMap((exception) => DbLoginFailure(exception.code))
        .map((model) => model.toEntity());
  }

  /// Registers a new user with the provided email and password.
  ///
  /// Returns a [Either] containing either an [AccessFailure] or a [LoginEntity].
  @override
  Future<Either<AccessFailure, LoginEntity>> register(String email, String password) async {
    final response = await datasource.register(email, password);
    return response
        .leftMap((exception) => RegisterFailure(exception.code))
        .map((model) => model.toEntity());
  }

  /// Requests an account recovery email for the user with the provided email.
  ///
  /// Returns a [Either] containing either an [AccessFailure] or a [Unit].
  @override
  Future<Either<AccessFailure, Unit>> requestAccountRecoveryEmail(String email) async {
    final response = await datasource.requestAccountRecoveryEmail(email);
    return response.leftMap((exception) => CredentialsFailure(exception.code));
  }

  /// Sets a new password for the user.
  ///
  /// Returns a [Either] containing either an [AccessFailure] or a [Unit].
  @override
  Future<Either<AccessFailure, Unit>> setNewPassword(String newPassword) async {
    final response = await datasource.setNewPassword(newPassword);
    return response.leftMap((exception) => CredentialsFailure(exception.code));
  }

  /// Checks if the user is authenticated.
  ///
  /// Returns a [Either] containing either an [AccessFailure] or a [Unit].
  @override
  Future<Either<AccessFailure, Unit>> getToken() async {
    final response = await datasource.checkAuth();
    return response.leftMap((exception) => CredentialsFailure(exception.code));
  }

  /// Retrieves the user's role.
  ///
  /// Returns a [Either] containing either an [AccessFailure] or a [String].
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
