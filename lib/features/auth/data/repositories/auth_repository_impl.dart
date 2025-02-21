import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/data/datasources/supabase_auth_datasource_impl.dart';
import 'package:mi_fortitu/features/auth/domain/entities/intra_user.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _supabaseDatasource = SupabaseAuthDatasourceImpl();

  @override
  Future<Either<Failure, Unit>> authLogin(String email, String password) async {
    try {
      await _supabaseDatasource.login(email, password);
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
  Future<Either<Failure, Unit>> authRegister(String email, String password, String displayName) async {
    try {
      await _supabaseDatasource.register(email, password);
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
  Future<Either<Failure, Unit>> authLogout() async {
    try {
      await _supabaseDatasource.logout();
      return Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, IntraUser>> intraLogin() {
    // TODO: implement intraLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, IntraUser>> getIntraUserProfile(String login) {
    // TODO: implement getIntraUserProfile
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