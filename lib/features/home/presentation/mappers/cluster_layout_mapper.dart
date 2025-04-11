import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../../domain/entities/cluster_user_entity.dart';
import '../viewmodels/campus_layout_vm.dart';
import '../viewmodels/cluster_vm.dart';

class ClusterLayoutMapper {
  final CampusLayoutVm campusLayout;
  final List<ClusterUserEntity> users;

  ClusterLayoutMapper(this.campusLayout, this.users);

  static Either<HomeFailure, List<ClusterVm>> map(
    CampusLayoutVm campusLayout,
    List<ClusterUserEntity> users,
  ) {
    return Left(UnexpectedFailure('TODO'));
  }
}