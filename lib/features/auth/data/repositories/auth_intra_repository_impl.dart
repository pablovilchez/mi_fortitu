import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/core/services/intra_api_service.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';

class AuthIntraRepositoryImpl implements AuthIntraRepository {
  final AuthIntraDatasource datasource;
  final IntraApiService apiService;

  AuthIntraRepositoryImpl(this.datasource, this.apiService);

  @override
  Future<Either<Failure, Unit>> requestToken() async {
    final isAuthenticated = await apiService.getGrantedToken();
    return isAuthenticated.fold((notAuthenticated) async {
      final result = await datasource.requestNewTokens();
      return result.fold((failure) => Left(IntraLoginFailure(failure.title)), (data) async {
        final saveResult = await apiService.saveTokens(data);
        return saveResult.fold(
          (failure) => Left(IntraLoginFailure(failure.toString())),
          (_) => Right(unit),
        );
      });
    }, (r) => Right(unit));
  }
}
