import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//TEXT STYLES

class AppTextStyle {
  AppTextStyle._();

  static TextStyle styleTextBottomNavigation(
      Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
          fontWeight: fontWeight, color: color, fontSize: 12.sp, height: 1.5),
    );
  }

  static TextStyle styleTextCustom(
      double sizeText, Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: sizeText,
      ),
    );
  }

  static TextStyle styleTextDefault10(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 10.sp,
      ),
    );
  }

  static TextStyle styleTextDefault10Underline(
      Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: 10.sp,
          decoration: TextDecoration.underline),
    );
  }

  static TextStyle styleTextDefault14Underline(
      Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: 14.sp,
          decoration: TextDecoration.underline),
    );
  }

  static TextStyle styleTextDefault12(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 12.sp,
      ),
    );
  }

  static TextStyle styleTextDefault12Underline(
      Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
          fontWeight: fontWeight,
          color: color,
          fontSize: 12.sp,
          decoration: TextDecoration.underline),
    );
  }

  static TextStyle styleTextDefault14(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 14.sp,
      ),
    );
  }

  static TextStyle styleTextDefault16(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 16.sp,
      ),
    );
  }

  static TextStyle styleTextDefault18(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 18.sp,
      ),
    );
  }

  static TextStyle styleTextDefault20(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 20.sp,
      ),
    );
  }

  static TextStyle styleTextDefault22(Color color, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: 22.sp,
      ),
    );
  }

  static TextStyle styleTextAppbar(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize: 16.sp,
      ),
    );
  }

  static TextStyle styleTitleText(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: 32.sp,
      ),
    );
  }

  static TextStyle styleSubtitleText(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: 12.sp,
      ),
    );
  }

  static TextStyle styleTitleForm(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: 20.sp,
      ),
    );
  }

  static TextStyle styleSubtitleForm(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: 12.sp,
      ),
    );
  }

  static TextStyle styleSubtitleFormActive(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize: 12.sp,
      ),
    );
  }

  static TextStyle styleUnderline12(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: color,
        decoration: TextDecoration.underline,
        fontSize: 12.sp,
      ),
    );
  }

  static TextStyle styleUnderline14(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: color,
        decoration: TextDecoration.underline,
        fontSize: 14.sp,
      ),
    );
  }

  static TextStyle styleTextIcon(Color color) {
    return GoogleFonts.rubik(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: 28.sp,
      ),
    );
  }

  static TextStyle styleTextIconStep(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: 24.sp,
      ),
    );
  }

  static TextStyle styleTextInput(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: 16.sp,
      ),
    );
  }

  static TextStyle styleHintText(Color color) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: 14.sp,
      ),
    );
  }
}
