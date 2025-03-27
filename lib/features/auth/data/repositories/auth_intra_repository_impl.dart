import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/models/intra_login_model.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';

class AuthIntraRepositoryImpl implements AuthIntraRepository {
  final AuthIntraDatasource datasource;

  AuthIntraRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, IntraLoginModel>> getIntraClient() async {
    try {
      final client = await datasource.getIntraClient();
      return Right(IntraLoginModel.fromIntraClient(client));
    } catch (e) {
      return Left(IntraLoginFailure('Failed to create client: $e'));
    }
  }
}
