import 'package:flutter/material.dart';

import '../../domain/entities/cursus_user_entity.dart';

class ProfileUserSkills extends StatelessWidget {
  final CursusUserEntity cursus;

  const ProfileUserSkills({super.key, required this.cursus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(cursus.skills.length, (index) => skillBuilder(context, index)),
          ),
        ),
      ),
    );
  }

  Widget skillBuilder(BuildContext context, int index) {
    final skill = cursus.skills[index];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name.length <= 35 ? skill.name : '${skill.name.substring(0, 33)}...',
              style: const TextStyle(fontSize: 13),
            ),
            Text(skill.level.toStringAsFixed(2), style: const TextStyle(fontSize: 13)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                minHeight: 3,
                value: skill.level / 20,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation(Colors.cyan),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
