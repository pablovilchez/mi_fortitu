import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile.dart';

class ProfileUserProjects extends StatelessWidget {
  final CursusUser cursus;

  const ProfileUserProjects({super.key, required this.cursus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Project List of ${cursus.cursus.name}'),
        ),
      ),
    );
  }
}
