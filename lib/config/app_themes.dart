import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/config/resources/text_styles.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData main({
    final bool isDark = false,
  }) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: isDark ? AppColors.white : AppColors.black,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.white,
      cardColor: isDark ? AppColors.black : AppColors.white,
      canvasColor: isDark ? AppColors.black : AppColors.white,
      focusColor: isDark ? AppColors.white : AppColors.black,
      hintColor: isDark ? AppColors.black : AppColors.white,
      iconTheme: IconThemeData(
        color: isDark ? AppColors.white : AppColors.black,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDark ? AppColors.black : AppColors.white,
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     foregroundColor: Colors.white,
      //     backgroundColor: AppColors.colorPrimary, // Default text color
      //     padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0, vertical: 12.0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(16.0),
      //     ),
      //   ),
      // ),
      navigationBarTheme: NavigationBarThemeData(
        height: 86,
        backgroundColor: AppColors.white,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (final Set<WidgetState> states) {
            return h14(
              fontWeight: FontWeight.w500,
              color: states.contains(WidgetState.selected)
                  ? AppColors.colorPrimary // Selected text color
                  : AppColors.black, // Unselected text color
            );
          },
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.black : AppColors.white,
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      ),
      dialogBackgroundColor: isDark ? AppColors.black : AppColors.white,
      hoverColor: isDark ? AppColors.white : AppColors.black,
      switchTheme: SwitchThemeData(
        trackColor:
            WidgetStateProperty.resolveWith<Color>((final Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.colorPrimary;
          }
          return AppColors.greyE9;
        }),
        trackOutlineColor:
            WidgetStateProperty.resolveWith<Color>((final Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          return Colors.transparent;
        }),
        trackOutlineWidth:
            WidgetStateProperty.resolveWith<double>((final Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return 0;
          }
          return 0;
        }),
        thumbColor:
            WidgetStateProperty.resolveWith<Color>((final Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white;
          }
          return AppColors.white;
        }),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.colorPrimary
      ),
      dividerColor: isDark
          ? AppColors.white.withOpacity(0.2)
          : AppColors.black.withOpacity(0.1),
      textTheme: TextTheme(
        displaySmall: h18(color: isDark ? AppColors.white : AppColors.black),
        headlineMedium:
            h24(color: isDark ? AppColors.white : AppColors.black),
        headlineSmall: h24(color: isDark ? AppColors.white : AppColors.black),
        bodySmall: h12(color: isDark ? AppColors.white : AppColors.black),
        bodyMedium: h14(color: isDark ? AppColors.white : AppColors.black),
        bodyLarge: h20(color: isDark ? AppColors.white : AppColors.black),
        titleSmall: h14(color: isDark ? AppColors.white : AppColors.black),
        titleMedium: h16(color: isDark ? AppColors.white : AppColors.black),
        titleLarge: h18(color: isDark ? AppColors.white : AppColors.black),
        labelSmall: h12(color: isDark ? AppColors.white : AppColors.black),
        labelMedium: h16(color: AppColors.black),
        labelLarge: h20(color: isDark ? AppColors.white : AppColors.black),
      ),
    );
  }
}
