import 'package:flutter/material.dart';
import 'package:mi_fortitu/core/ui/widgets/pastel_card.dart';

import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/intra_profile.dart';

class HomeProfileCard extends StatelessWidget {
  final IntraProfile profile;
  const HomeProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return PastelCard(
      backgroundColor: AppColors.pastelPurple.mainColor,
      borderColor: AppColors.pastelPurple.borderColor,
      child: Column(
        children: [
          Row(
            children: [
              _buildProfileAvatar(),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Mastermind pvilchez', style: TextStyle(fontSize: 13)),
                    SizedBox(height: 8),
                    _buildProfileExperience(level: 11.58),
                  ],
                ),
              ),
              SizedBox(width: 24),
              _buildRightIcon(icon: Icons.settings_outlined),
            ],
          ),
          SizedBox(height: 16),
          _buildCursusInfo(cursus: '42cursus', grade: 'member'),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: const DecorationImage(
          image: AssetImage('assets/images/default_avatar.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: AppColors.pastelPurple.borderColor, width: 2),
      ),
    );
  }

  Widget _buildProfileExperience({required double level}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          // decoration: BoxDecoration(
          //   color: AppColors.pastelPurple.darkColor,
          //   borderRadius: BorderRadius.circular(12),
          // ),
          child: Text(
            'Lvl. ${level.truncate()}',
            style: TextStyle(
              color: AppColors.pastelPurple.darkColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: level % 1,
              backgroundColor: AppColors.pastelPurple.borderColor,
              color: AppColors.pastelPurple.darkColor,
              minHeight: 8,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${(level * 100).truncate() % 100}%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.pastelPurple.darkColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRightIcon({required IconData icon}) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.grey[600]),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildCursusInfo({required String cursus, required String grade}) {
    final String gradeCrop =
        grade.length <= 8 ? grade : '${grade.substring(0, 7)}...';
    final String cursusCrop =
        cursus.length <= 19 ? cursus : '${cursus.substring(0, 17)}...';

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCoalitionAvatar(),
        SizedBox(width: 16),
        SizedBox(
          width: 90,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    'Grade:',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    gradeCrop,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Cursus:',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            SizedBox(width: 8),
            Row(
              children: [
                SizedBox(width: 6),
                Text(cursusCrop, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoalitionAvatar() {
    return SizedBox(
      width: 60,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: AssetImage('assets/images/default_coalition.png'),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: AppColors.pastelPurple.borderColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
