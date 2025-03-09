import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile.dart';

class ProfileUserSkills extends StatelessWidget {
  final CursusUser cursus;

  const ProfileUserSkills({super.key, required this.cursus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Cursus Skills of ${cursus.cursus.name}'),
        ),
      ),
    );
  }
}
