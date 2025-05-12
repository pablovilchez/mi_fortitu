import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cursus_user_entity.dart';

class ProfileLevelUserProjects extends StatelessWidget {
  final CursusUserEntity cursus;

  const ProfileLevelUserProjects({super.key, required this.cursus});

  @override
  Widget build(BuildContext context) {
    final int percentage = (cursus.level * 100 % 100).truncate();
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr('profile.user.grade')}:',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(cursus.grade, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    '${tr('profile.user.level')}:',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    cursus.level.truncate().toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      '${percentage.toString()}%',
                      style: const TextStyle(fontSize: 12),
                    ),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: percentage / 100,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation(Colors.cyan),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
