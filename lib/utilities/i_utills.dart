import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quick_backup/constants/app_colors.dart';
import '../configurations/size_config.dart';
import 'custom_theme.dart';

class iUtills {
  Widget upperRoundedContainer(context, width, height,
      {Widget? child, required color}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                offset: Offset(0.2, 0.3),
                blurRadius: 1.5)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48), topRight: Radius.circular(48)),
          color: color),
      child: child,
    );
  }

  Widget bottomRoundedContainer(context, width, height, {Widget? child}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22))),
      child: child,
    );
  }

  Widget roundedContainer(context, {Widget? child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: child,
    );
  }

  Widget gradientButton({width, height, child}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            Color(0xffFFA37C),
            Color(0xffFE7940),
            Color(0xffFF9A70),
          ])),
      child: child,
    );
  }

  static Widget glassContainer({
    required var context,
    required var width,
    required var height,
    required child,
  }) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: 22,
      blur: 4,
      border: 0.1,
      linearGradient: CustomTheme.iLinearGradient,
      borderGradient: CustomTheme.iBorderGradient,
      child: child,
    );
  }
}

double getScreenWidth(context) => MediaQuery.of(context).size.width;

double getScreenHeight(context) => MediaQuery.of(context).size.height;
