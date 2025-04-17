import 'package:mi_fortitu/features/home/domain/entities/cluster_user_entity.dart';

class ProjectsUsersVm {
  final String projectName;
  final List<ClusterUserEntity> users;

  ProjectsUsersVm({
    required this.projectName,
    required this.users,
  });
}
