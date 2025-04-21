import 'package:dartz/dartz.dart';

import '../../../../core/services/intra_api_client.dart';
import '../access_failure.dart';

class CheckIntraAuthUsecase {
  final IntraApiClient intraApiClient;

  CheckIntraAuthUsecase(this.intraApiClient);

  Future<Either<AccessFailure, Unit>> call() async {
    final tokenResult = await intraApiClient.getGrantedToken();
    return tokenResult.fold(
          (error) => Left(IntraLoginFailure('IT00')),
          (_) => Right(unit),
    );
  }
}
