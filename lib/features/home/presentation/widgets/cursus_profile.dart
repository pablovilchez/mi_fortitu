import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile_entity.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_card.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_level_card.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_projects.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_skills.dart';

class CursusProfile extends StatefulWidget {
  final IntraProfileEntity profile;

  const CursusProfile({super.key, required this.profile});

  @override
  State<CursusProfile> createState() => _CursusProfileState();
}

class _CursusProfileState extends State<CursusProfile> {
  CursusUser? _selectedCursus;

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
    final List<ProjectsUser> cursusProjects = widget.profile.projectsUsers
        .where((project) => project.cursusIds.contains(_selectedCursus!.cursus.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Cursus:'),
              SizedBox(width: 16),
              DropdownButton<CursusUser>(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                value: _selectedCursus,
                onChanged: (CursusUser? newValue) {
                  setState(() {
                    _selectedCursus = newValue;
                  });
                },
                items:
                widget.profile.cursusUsers
                    .map<DropdownMenuItem<CursusUser>>((
                    CursusUser cursusUser,) {
                  return DropdownMenuItem<CursusUser>(
                    value: cursusUser,
                    child: Text(cursusUser.cursus.name),
                  );
                })
                    .toList(),
              ),
            ],
          ),
          if (_selectedCursus != null) ...[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileUserCard(profile: widget.profile),
                    buildTitle(tr('profile.experience')),
                    ProfileLevelUserProjects(cursus: _selectedCursus!),
                    buildTitle(tr('profile.skills')),
                    ProfileUserSkills(cursus: _selectedCursus!),
                    buildTitle(tr('profile.projects')),
                    ProfileUserProjects(projectList: cursusProjects),
                  ],
                ),
              ),
            ),

          ] else
            ...[
              Center(child: Text('No cursus found.')),
            ],
        ],
      ),
    );
  }
  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 15.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
