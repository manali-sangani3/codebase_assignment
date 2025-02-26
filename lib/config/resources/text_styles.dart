import 'package:flutter/material.dart';

import '../app_colors.dart';

const String fontFamilyDMSans = "DMSans";

TextStyle dmSansText(double fontSize,
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    String? fontFamily,
    Color? color = AppColors.black,
    Color? decorationColor = AppColors.black,
    bool hasUnderLine = false,
    double? height}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      height: height ?? 1.2,
      overflow: textOverflow ?? TextOverflow.visible,
      fontWeight: fontWeight,
      decoration: hasUnderLine ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
      fontFamily: fontFamily);
}

TextStyle h8(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(8,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h10(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(10,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h12(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(12,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h14(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(14,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h15(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(14,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h16(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(16,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h18(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(18,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h20(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(20,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h22(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w700,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(22,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h24(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w700,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(24,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}

TextStyle h48(
    {BuildContext? context,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow? textOverflow,
    Color? color = AppColors.black}) {
  return dmSansText(48,
      context: context,
      fontWeight: fontWeight,
      fontFamily: fontFamilyDMSans,
      textOverflow: textOverflow,
      color: color);
}
