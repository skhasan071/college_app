import 'package:flutter/material.dart';

class CustomTheme {
  final Color brochureBtnColor; // card.dart
  final Color starColor;
  final Color nirfTextColor;
  final Color courseCountColor;
  final Color filterSelectedColor; // filter.dart
  final Color filterTextColor;
  final LinearGradient backgroundGradient; //College.dart
  final LinearGradient boxGradient;
  final List<BoxShadow> boxShadow;

  const CustomTheme({
    required this.brochureBtnColor,
    required this.starColor,
    required this.nirfTextColor,
    required this.courseCountColor,
    required this.filterSelectedColor,
    required this.filterTextColor,
    required this.backgroundGradient,
    required this.boxGradient,
    required this.boxShadow,
  });
}

class AppThemes {
  static final blackWhiteTheme = CustomTheme(
    brochureBtnColor: Colors.black,
    starColor: Colors.black,
    nirfTextColor: Colors.black,
    courseCountColor: Colors.black,
    filterSelectedColor: Colors.black,
    filterTextColor: Colors.white,
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.white],
    ),
    boxGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Colors.white],
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFB197D8).withOpacity(0.3),
        blurRadius: 14,
        spreadRadius: 2,
        offset: Offset(0, 6),
      ),
    ],
  );

  static final coloredTheme = CustomTheme(
    brochureBtnColor: Colors.green,
    starColor: Colors.amber,
    nirfTextColor: Colors.green,
    courseCountColor: Colors.blue,
    filterSelectedColor: Color(0xff4B0082),
    filterTextColor: Colors.white,
    backgroundGradient: const LinearGradient(
      begin: Alignment(-0.9, -0.9),
      end: Alignment(1.2, 1.2),
      colors: [
        Color(0xFFF8F2FC),
        Color(0xFFEADFF9),
        Color(0xFFDBC9F1),
        Color(0xFFD2C0ED),
      ],
      stops: [0.0, 0.3, 0.7, 1.0],
      tileMode: TileMode.clamp,
    ),

    boxGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFDDEEFF), Color(0xFFB3D1F1)],
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFB197D8).withOpacity(0.1),
        blurRadius: 14,
        spreadRadius: 2,
        offset: Offset(0, 6),
      ),
    ],
  );
}
