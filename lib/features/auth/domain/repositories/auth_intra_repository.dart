import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

/// An abstract class representing the repository for Intra authentication.
abstract class AuthIntraRepository {
  /// Try to get the authorization when the user doesn't have a valid token
  Future<Either<Failure, Unit>> requestToken();
}
