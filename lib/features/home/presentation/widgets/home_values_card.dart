import 'package:flutter/material.dart';
import 'package:mi_fortitu/core/themes/app_colors.dart';
import 'package:mi_fortitu/core/ui/widgets/pastel_card.dart';

class HomeValuesCard extends StatelessWidget {
  const HomeValuesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PastelCard(
      backgroundColor: AppColors.pastelYellow.mainColor,
      borderColor: AppColors.pastelYellow.borderColor,
      child: Row(
        children: [
          _buildStatItem(label: '₳', value: 1208),
          SizedBox(width: 16),
          _buildStatItem(label: 'EP', value: 5),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required int value,
    Color labelColor = Colors.grey,
  }) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: labelColor)),
          const SizedBox(height: 4),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
