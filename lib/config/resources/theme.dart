import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(brightness) {
  var baseTheme = ThemeData(
      brightness: brightness, scaffoldBackgroundColor: AppColors.white);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.dmSansTextTheme(baseTheme.textTheme),
  );
}
