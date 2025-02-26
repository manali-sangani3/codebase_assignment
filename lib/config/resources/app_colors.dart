import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color colorPrimary = Color(0xFF4947D0);
  static const Color pageBackground = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color black22 = Color(0xFF222222);
  static const Color greyE9 = Color(0xFFE9E9E9);
  static const Color greyF5 = Color(0xFFF5F5F5);
  static const Color grey77 = Color(0xFF6B7177);
  static const Color boxShadow = Color(0x1a404f68);
  static const Color shadowC4 = Color(0x1A3445C4);
  static const Color purpleC4 = Color(0x1A3445C4);
  static const Color gradient1 = Color(0xFF3D1FB1);
  static const Color purple5C4 = Color(0xFF3445C4);
  static const Color blueFA = Color(0xFFF1FCFA);
  static const Color gradient3 = Color(0xFF1674C5);
  static const Color blueC4 = Color(0xFF126BC4);
  static const Color blueE9 = Color(0xFF1967D2);
  static const Color errorColor = Color(0xFFBA1A1A);
  static const Color red00 = Color(0xFFD50000);
  static const Color redA00 = Color(0x1AD50000);
  static const Color red25 = Color(0xFFD93025);
  static const Color green7B = Color(0xFF5BBB7B);
  static const Color green3F = Color(0xFF1F4B3F);
  static const Color documentBackground = Color(0xFFF9F9FB);
  static const Color yellow3F = Color(0xFFE1C03F);

  //Gradient Colors
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [gradient1, purple5C4, gradient3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
