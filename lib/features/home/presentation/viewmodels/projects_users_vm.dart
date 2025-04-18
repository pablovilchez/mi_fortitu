import 'package:mi_fortitu/features/home/domain/entities/location_entity.dart';

class ProjectsUsersVm {
  final String projectName;
  final List<LocationEntity> users;

  ProjectsUsersVm({
    required this.projectName,
    required this.users,
  });
}
