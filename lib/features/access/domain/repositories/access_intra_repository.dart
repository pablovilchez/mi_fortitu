import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/domain/access_failure.dart';

/// An abstract class representing the repository for Intra authentication.
abstract class AccessIntraRepository {
  /// Try to get the authorization when the user doesn't have a valid token
  Future<Either<AccessFailure, Unit>> requestToken();
}
