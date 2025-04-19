import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/core/services/intra_api_client.dart';
import 'package:mi_fortitu/features/access/data/datasources/access_intra_datasource.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/repositories/access_intra_repository.dart';

class AccessIntraRepositoryImpl implements AccessIntraRepository {
  final AccessIntraDatasource datasource;
  final IntraApiClient apiService;

  AccessIntraRepositoryImpl(this.datasource, this.apiService);

  @override
  Future<Either<AccessFailure, Unit>> requestToken() async {
    final isAuthenticated = await apiService.getGrantedToken();
    return isAuthenticated.fold((notAuthenticated) async {
      final result = await datasource.requestNewTokens();
      return result.fold((e) => Left(IntraLoginFailure(e.code)), (data) async {
        final saveResult = await apiService.saveTokens(data);
        return saveResult.fold(
          (e) => Left(IntraLoginFailure(e.toString())),
          (_) => Right(unit),
        );
      });
    }, (r) => Right(unit));
  }
}
