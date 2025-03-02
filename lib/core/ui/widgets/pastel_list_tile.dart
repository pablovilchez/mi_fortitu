import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class PastelListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final ColorSet colorSet;
  final IconData icon;
  final String? route;

  const PastelListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.colorSet,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: colorSet.mainColor,
        border: Border.all(color: colorSet.borderColor),
        borderRadius:
            route != null
                ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )
                : BorderRadius.circular(10),
        boxShadow: AppShadows.tileShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          margin: const EdgeInsets.all(0),
          height: double.infinity,
          width: 50,
          decoration: BoxDecoration(
            color: colorSet.borderColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: colorSet.mainColor, size: 30),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorSet.darkColor,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        tileColor: Colors.transparent,
        trailing:
            route != null
                ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: colorSet.darkColor,
                )
                : null,
        onTap: route != null
            ? () {}
            : null,
      ),
    );
  }
}
