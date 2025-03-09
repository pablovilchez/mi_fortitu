import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_card.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_projects.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/profile_user_skills.dart';

class CursusProfile extends StatefulWidget {
  final IntraProfile intraProfile;

  const CursusProfile({super.key, required this.intraProfile});

  @override
  State<CursusProfile> createState() => _CursusProfileState();
}

class _CursusProfileState extends State<CursusProfile> {
  CursusUser? _selectedCursus;

  @override
  void initState() {
    if (widget.intraProfile.cursusUsers.isNotEmpty) {
      _selectedCursus = widget.intraProfile.cursusUsers.firstWhere(
        (cursus) => cursus.cursus.kind == 'main',
        orElse: () => widget.intraProfile.cursusUsers.first,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.intraProfile.cursusUsers
                        .map<DropdownMenuItem<CursusUser>>((
                          CursusUser cursusUser,
                        ) {
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
            SingleChildScrollView(
              child: Column(
                children: [
                  ProfileUserCard(intraProfile: widget.intraProfile),
                  SizedBox(height: 16),
                  ProfileUserSkills(cursus: _selectedCursus!),
                  SizedBox(height: 16),
                  ProfileUserProjects(cursus: _selectedCursus!),
                ],
              ),
            ),
          ] else ...[
            Center(child: Text('No cursus found.')),
          ],
        ],
      ),
    );
  }
}
