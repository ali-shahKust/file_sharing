import 'package:flutter/material.dart';
import 'package:quick_backup/constants/app_colors.dart';
class PrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextOverflow? overflow;
  final TextAlign textAlign;
  final bool? softWrap;
  final int? maxLines;

  PrimaryText(
      this.text, {
        this.fontSize,
        this.maxLines,
        this.softWrap,
        this.color = AppColors.kWhiteColor,
        this.fontWeight = FontWeight.normal,
        this.overflow,
        this.textAlign = TextAlign.start,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: "AvenirNextLTPro"
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextOverflow? overflow;

  CustomText(
      this.text,
      this.textStyle, {
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: textStyle,
    );
  }
}