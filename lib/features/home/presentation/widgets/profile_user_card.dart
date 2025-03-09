import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/domain/entities/intra_profile.dart';

class ProfileUserCard extends StatelessWidget {
  final IntraProfile intraProfile;

  const ProfileUserCard({super.key, required this.intraProfile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Profile User Card of ${intraProfile.login}'),
        ),
      ),
    );
  }
}
