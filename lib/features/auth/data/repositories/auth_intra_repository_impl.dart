import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/core/services/intra_api_service.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';

class AuthIntraRepositoryImpl implements AuthIntraRepository {
  final AuthIntraDatasource datasource;
  final IntraApiService tokenService;

  AuthIntraRepositoryImpl(this.datasource, this.tokenService);

  @override
  Future<Either<Failure, Unit>> requestNewToken() async {
    try {
      final data = await datasource.authenticate();
      await tokenService.saveTokens(data);
      return Right(unit);
    } catch (e) {
      return Left(IntraLoginFailure('Failed to create client: $e'));
    }
  }
}
