import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/data/datasources/intra_datasource_impl.dart';
import 'package:mi_fortitu/features/auth/domain/entities/intra_user.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/intra_repository.dart';


class IntraRepositoryImpl implements IntraRepository {
  final _intraDataSource = IntraDatasourceImpl();
  
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

}