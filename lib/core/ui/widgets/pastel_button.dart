import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class PastelButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PastelButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pastelPink.mainColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: AppColors.shadow.withAlpha(30),
        elevation: 5,
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
