import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/project_user_entity.dart';

class ProfileUserProjects extends StatelessWidget {
  final List<ProjectUserEntity> projectList;

  const ProfileUserProjects({super.key, required this.projectList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(
              projectList.length,
              (index) => projectBuilder(context, index),
            ),
          ),
        ),
      ),
    );
  }

  Widget projectBuilder(BuildContext context, int index) {
    final project = projectList[index];
    final color = project.validated ? Colors.green : Colors.red;
    final excess = (project.finalMark - 100) / 100;
    final ago =
        DateTime.now().difference(DateTime.parse(project.updatedAt)).inDays;
    final years = (ago / 365).truncate();
    final months = ((ago % 365) / 30).truncate();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: project.finalMark / 100,
                    backgroundColor: Colors.black12,
                    valueColor: AlwaysStoppedAnimation(color),
                    strokeWidth: 5,
                  ),
                  if (project.finalMark > 100)
                    CircularProgressIndicator(
                      value: excess,
                      valueColor: AlwaysStoppedAnimation(Colors.amber),
                      strokeWidth: 3,
                    ),
                  if (project.status != 'in_progress')
                    Center(
                      child: Text(
                        project.finalMark.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color:
                              project.finalMark > 100
                                  ? Colors.orangeAccent
                                  : color,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.project.name.length > 30
                          ? '${project.project.name.substring(0, 27)}...'
                          : project.project.name,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(tr('home.project_states.${project.status}'), style: const TextStyle(fontSize: 13)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${tr('profile.attempts')}: ${project.occurrence}'),
                    Text(
                      project.marked
                          ? tr('profile.closed')
                          : tr('profile.opened'),
                      style: TextStyle(
                        color: project.marked ? Colors.red : Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${tr('profile.ago')} '),
                          if (years > 0) Text('$years${tr('profile.years')} '),
                          Text('$months${tr('profile.months')}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
