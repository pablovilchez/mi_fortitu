import 'package:flutter/material.dart';

class ColorSet {
  final Color mainColor;
  final Color darkColor;
  final Color borderColor;

  const ColorSet({
    required this.mainColor,
    required this.darkColor,
    required this.borderColor,
  });
}

class AppColors {
  static const ColorSet triPrimary = ColorSet(
    mainColor: Color(0xFFBDE0FE),
    darkColor: Color(0xFF02458C),
    borderColor: Color(0xFF8FC5FF),
  );


  static const ColorSet pastelBlue = ColorSet(
    mainColor: Color(0xFFBDE0FE),
    darkColor: Color(0xFF02458C),
    borderColor: Color(0xFF8FC5FF),
  );

  static const ColorSet pastelGreen = ColorSet(
    mainColor: Color(0xFFD0FEEB),
    darkColor: Color(0xFF0A7A5A),
    borderColor: Color(0xFFA3FCD6),
  );

  static const ColorSet pastelOrange = ColorSet(
    mainColor: Color(0xFFFFE0B2),
    darkColor: Color(0xFFE65100),
    borderColor: Color(0xFFFFC491),
  );

  static const ColorSet pastelPink = ColorSet(
    mainColor: Color(0xFFFFC8DD),
    darkColor: Color(0xFFD50076),
    borderColor: Color(0xFFFFA1C2),
  );

  static const ColorSet pastelPurple = ColorSet(
    mainColor: Color(0xF9DFE0FA),
    darkColor: Color(0xFF6A00FF),
    borderColor: Color(0xF9C9CAFC),
  );

  static const ColorSet pastelRed = ColorSet(
    mainColor: Color(0xFFFFB2B2),
    darkColor: Color(0xFFD32F2F),
    borderColor: Color(0xFFFF8F8F),
  );

  static const ColorSet pastelYellow = ColorSet(
    mainColor: Color(0xFFFFF1E6),
    darkColor: Color(0xFFFF8F00),
    borderColor: Color(0xFFE6D4C3),
  );

  static const Color accent = Color(0xFFFFAFCC);
  static const Color accentBorder = Color(0xFFFF8FB3);

  static const Color shadow = Color(0xFF999999);
  static const Color shadowBorder = Color(0xFF666666);
}

class AppShadows {
  static List<BoxShadow> tileShadow = [
    BoxShadow(
      color: Colors.white.withAlpha(80),
      offset: const Offset(-3, -3),
      blurRadius: 5,
    ),
    BoxShadow(
      color: AppColors.shadow.withAlpha(80),
      offset: const Offset(4, 4),
      blurRadius: 5,
    ),
  ];
}
