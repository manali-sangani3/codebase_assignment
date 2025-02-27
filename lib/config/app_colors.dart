import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color pageBackground = Color(0xFF8185E2);
  static const Color colorSecondary = Color(0xFF8185E2);
  static const Color colorPrimary = Color(0xFF8185E2);
  static const Color textColorContent = Color(0xFF6F6F6F);
  static const Color shimmerLoadingColor = Color(0xFF6F6F6F);
  static const Color deleteIconColor = Color(0xFFC50F0F);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black22 = Color(0xFF222222);
  static const Color greyE9 = Color(0xFFE9E9E9);
  static const Color greyF5 = Color(0xFFF5F5F5);
  static const Color grey77 = Color(0xFF6B7177);
  static const Color disableColor = Color(0xFF909396);
  static const Color purpleC4 = Color(0xFF8185E2);
  static const Color shadowC4 = Color(0x1A3445C4);
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

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: pageBackground,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFA6EDFF),
    onPrimaryContainer: Color(0xFF001F26),
    secondary: Color(0xFF4B6268),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCDE7EE),
    onSecondaryContainer: Color(0xFF061F24),
    tertiary: Color(0xFF565D7E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFDCE1FF),
    onTertiaryContainer: Color(0xFF121A37),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFFFAFCFD),
    onBackground: Color(0xFF191C1D),
    surface: Color(0xFFFAFCFD),
    onSurface: Color(0xFF191C1D),
    surfaceVariant: Color(0xFFDBE4E7),
    onSurfaceVariant: Color(0xFF3F484B),
    outline: Color(0xFF70797C),
    onInverseSurface: Color(0xFFEFF1F2),
    inverseSurface: Color(0xFF2E3132),
    inversePrimary: Color(0xFF55D7F3),
    shadow: Color(0xFF000000),
  );
}
