import 'package:flutter/material.dart';
import 'package:mi_fortitu/core/ui/widgets/pastel_list_tile.dart';

import '../../../../core/themes/app_colors.dart';

class HomeTilesGroup extends StatelessWidget {
  final String title;
  final ColorSet colorSet;

  const HomeTilesGroup({
    super.key,
    required this.title,
    required this.colorSet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        SizedBox(height: 5),
        PastelListTile(
          title: 'Student Profile',
          icon: Icons.person,
          colorSet: colorSet,
          route: '/test',
        ),
        PastelListTile(
          title: 'Projects',
          icon: Icons.work,
          colorSet: colorSet,
        ),
        PastelListTile(
          title: 'Evaluation Slots',
          icon: Icons.calendar_today,
          colorSet: colorSet,
        ),
        PastelListTile(
          title: 'Achievements',
          icon: Icons.emoji_events,
          colorSet: colorSet,
        ),
        PastelListTile(
          title: 'Coalitions',
          icon: Icons.group,
          colorSet: colorSet,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
