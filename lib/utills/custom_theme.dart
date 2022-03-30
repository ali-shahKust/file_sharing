import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xff000264);
  static const Color secondaryColor = Color(0xFF04619f);
  static const Color black = Color(0xFF0F0f0f);
  static const Color white = Color(0xffF7F8FC);
  static const Color scafBackground = Color(0xffEFF1FA);

  static var iLinearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor,
        secondaryColor
      ],
    );

  static var iBorderGradient = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        primaryColor,
        secondaryColor
      ],
      stops: [
        0.06,
        0.95,
      ]);
}