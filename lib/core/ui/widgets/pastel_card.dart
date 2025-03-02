import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class PastelCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String? title;
  final String? subtitle;
  final Widget? child;

  const PastelCard({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        boxShadow: AppShadows.tileShadow,
      ),
      child: child,
    );
  }
}
