import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/core/errors/exceptions.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_supa_datasource.dart';
import 'package:mi_fortitu/features/auth/data/models/supa_login_model.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_supa_repository.dart';

class AuthSupaRepositoryImpl implements AuthSupaRepository {
  final AuthSupaDatasource datasource;

  AuthSupaRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, SupaLoginModel>> login(String email, String password) async {
    try {
      final response = await datasource.login(email, password);
      if (response.user == null) {
        return Left(AuthFailure('Cannot identify user'));
      }
      return Right(SupaLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SupaLoginModel>> register(String email, String password) async {
    try {
      final response = await datasource.register(email, password);
      if (response.user == null) {
        return Left(AuthFailure('Cannot register user'));
      }
      return Right(SupaLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(RegisterFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProfile() async {
    try {
      await datasource.addProfile();
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> checkProfileCredentials() async {
    try {
      datasource.checkProfileCredentials();
      return Right(unit);
    } catch (e) {
      return Left(CredentialsFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getRole() async {
    try {
      return Right(await datasource.getRole());
    } on DataException catch (e) {
      datasource.addProfile();
      return Right('waitlist');
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
