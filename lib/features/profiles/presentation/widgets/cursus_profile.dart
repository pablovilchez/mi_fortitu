import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/profiles/domain/entities/user_entity.dart';
import 'package:mi_fortitu/features/profiles/presentation/widgets/profile_user_card.dart';
import 'package:mi_fortitu/features/profiles/presentation/widgets/profile_user_level_card.dart';
import 'package:mi_fortitu/features/profiles/presentation/widgets/profile_user_projects.dart';
import 'package:mi_fortitu/features/profiles/presentation/widgets/profile_user_skills.dart';

import '../../domain/entities/cursus_user_entity.dart';
import '../../domain/entities/project_user_entity.dart';

class CursusProfile extends StatefulWidget {
  final UserEntity profile;

  const CursusProfile({super.key, required this.profile});

  @override
  State<CursusProfile> createState() => _CursusProfileState();
}

class _CursusProfileState extends State<CursusProfile> {
  CursusUserEntity? _selectedCursus;

  @override
  void initState() {
    if (widget.profile.cursusUsers.isNotEmpty) {
      _selectedCursus = widget.profile.cursusUsers.firstWhere(
        (cursus) => cursus.cursus.kind == 'main',
        orElse: () => widget.profile.cursusUsers.first,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ProjectUserEntity> cursusProjects =
        widget.profile.projectsUsers
            .where((project) => project.cursusIds.contains(_selectedCursus!.cursus.id))
            .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Cursus:'),
              const SizedBox(width: 16),
              DropdownButton<CursusUserEntity>(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                value: _selectedCursus,
                onChanged: (CursusUserEntity? newValue) {
                  setState(() {
                    _selectedCursus = newValue;
                  });
                },
                items:
                    widget.profile.cursusUsers.map<DropdownMenuItem<CursusUserEntity>>((
                        CursusUserEntity cursusUser,
                    ) {
                      final cursusName = cursusUser.cursus.name.length > 30
                          ? '${cursusUser.cursus.name.substring(0, 27)}...'
                          : cursusUser.cursus.name;
                      return DropdownMenuItem<CursusUserEntity>(
                        value: cursusUser,
                        child: Text(cursusName),
                      );
                    }).toList(),
              ),
            ],
          ),
          if (_selectedCursus != null) ...[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileUserCard(profile: widget.profile),
                    buildTitle(tr('profile.section.experience')),
                    ProfileLevelUserProjects(cursus: _selectedCursus!),
                    buildTitle(tr('profile.section.skills')),
                    ProfileUserSkills(cursus: _selectedCursus!),
                    buildTitle(tr('profile.section.projects')),
                    ProfileUserProjects(projectList: cursusProjects),
                  ],
                ),
              ),
            ),
          ] else ...[
            const Center(child: Text('No cursus found.')),
          ],
        ],
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 15.0),
      child: Row(
        children: [Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))],
      ),
    );
  }
}
