import 'package:flutter/material.dart';
import 'package:mi_fortitu/core/themes/app_colors.dart';

class PastelContainer extends StatelessWidget {
  final Widget? child;
  const PastelContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pastelBlue.mainColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
