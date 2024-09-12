import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klontong_project/features/common/app_colors.dart';
import 'package:klontong_project/features/common/app_text_style.dart';
import 'package:klontong_project/utils/hex_color.dart';

class AppTheme {
  AppTheme._();

  static theme() {
    return ThemeData(
      primaryColor: AppColors.mainColorWhite,
      primaryColorDark: HexColor.getColorFromHex('#3D3939'),
      fontFamily: GoogleFonts.poppins().fontFamily,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        titleLarge:
            AppTextStyle.styleTextDefault22(AppColors.text50, FontWeight.bold),
        titleMedium:
            AppTextStyle.styleTextDefault20(AppColors.text50, FontWeight.bold),
        titleSmall:
            AppTextStyle.styleTextDefault18(AppColors.text50, FontWeight.bold),
        bodyLarge:
            AppTextStyle.styleTextDefault16(AppColors.text30, FontWeight.w500),
        bodyMedium:
            AppTextStyle.styleTextDefault14(AppColors.text30, FontWeight.w500),
        bodySmall:
            AppTextStyle.styleTextDefault12(AppColors.text30, FontWeight.w500),
        labelLarge: AppTextStyle.styleTextDefault16(
            AppColors.mainColorWhite, FontWeight.w500),
        labelMedium: AppTextStyle.styleTextDefault14(
            AppColors.mainColorWhite, FontWeight.w500),
        labelSmall: AppTextStyle.styleTextDefault12(
            AppColors.mainColorWhite, FontWeight.w500),
      ),
    );
  }
}
