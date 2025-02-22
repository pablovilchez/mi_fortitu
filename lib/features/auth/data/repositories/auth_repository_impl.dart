import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/data/datasources/supabase_auth_datasource_impl.dart';
import 'package:mi_fortitu/features/auth/data/models/auth_user_model.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _supabaseDatasource = SupabaseAuthDatasourceImpl();

  @override
  Future<Either<Failure, AuthUserModel>> authLogin(String email, String password) async {
    try {
      final user = await _supabaseDatasource.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> authSignIn(
    String email,
    String password,
  ) async {
    try {
      final user = await _supabaseDatasource.register(email, password);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> authSignOut() async {
    try {
      await _supabaseDatasource.signOut();
      return Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> authCheck() async {
    try {
      await _supabaseDatasource.checkAuth();
      return Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> authResetPassword(String password) {
    // TODO: implement authResetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkApproval() async {
    try {
      final result = await _supabaseDatasource.checkApproval();
      return Right(result);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
