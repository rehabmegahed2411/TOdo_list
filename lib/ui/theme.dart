import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

const color1 = Color(0xFF8ABAC5);
const color2 = Color(0xFFD9D9D9);
const color3 = Color(0xFFCDE2E6);
const darkColor = Color(0xFF121212);

class Themes {
  static final light = ThemeData(
    primaryColor: Color(0xFF8ABAC5),
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: Color(0xFF121212),
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode?Colors.grey[400]:Colors.grey
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode?Colors.white:Colors.black
  ));
}
TextStyle get TitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode?Colors.white:Colors.black
  ));
}
TextStyle get SubTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600]
  ));
}
