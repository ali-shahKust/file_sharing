// import 'package:flutter/material.dart';
// import 'package:quick_backup/utilities/custom_theme.dart';
//
// class PrimaryText extends StatelessWidget {
//   final String text;
//   final String fontFamily;
//   final double? fontSize;
//   final Color color;
//   final FontWeight fontWeight;
//   final TextOverflow? overflow;
//   final TextAlign textAlign;
//   final bool? softWrap;
//   final int? maxLines;
//   final double height;
//
//   PrimaryText(
//       this.text, {
//         this.fontSize,
//         this.fontFamily = 'Helvetica',
//         this.maxLines,
//         this.softWrap,
//         this.color = CustomTheme.black,
//         this.fontWeight = FontWeight.normal,
//         this.overflow = TextOverflow.ellipsis,
//         this.textAlign = TextAlign.start,
//         this.height = 1.0,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       overflow: overflow,
//       maxLines: maxLines,
//       softWrap: softWrap,
//       style: TextStyle(
//         height: height,
//         fontFamily: fontFamily,
//         fontSize: fontSize,
//         color: color,
//         fontWeight: fontWeight,
//       ),
//     );
//   }
// }
//
// class UnderLineText extends StatelessWidget {
//   final String text;
//   final String fontFamily;
//   final double? fontSize;
//   final Color color;
//   final FontWeight fontWeight;
//   final TextOverflow? overflow;
//   final TextAlign textAlign;
//   final bool? softWrap;
//   final int? maxLines;
//   final double height;
//   UnderLineText(
//       this.text, {
//         this.fontSize,
//         this.fontFamily = 'Helvetica',
//         this.maxLines,
//         this.softWrap,
//         this.color = CustomTheme.black,
//         this.fontWeight = FontWeight.normal,
//         this.overflow = TextOverflow.ellipsis,
//         this.textAlign = TextAlign.start,
//         this.height = 1.0,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       overflow: overflow,
//       maxLines: maxLines,
//       softWrap: softWrap,
//       style: TextStyle(
//         decoration: TextDecoration.underline,
//         height: height,
//         fontFamily: fontFamily,
//         fontSize: fontSize,
//         color: color,
//         fontWeight: fontWeight,
//       ),
//     );
//   }
// }
//
// class SecondaryText extends StatelessWidget {
//   final String text;
//   final double? fontSize;
//   final Color color;
//   final FontWeight fontWeight;
//   final TextOverflow? overflow;
//   final TextAlign textAlign;
//
//   SecondaryText(
//       this.text, {
//         this.fontSize,
//         this.color = CustomTheme.black,
//         this.fontWeight = FontWeight.normal,
//         this.overflow = TextOverflow.ellipsis,
//         this.textAlign = TextAlign.start,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       overflow: overflow,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontWeight: fontWeight,
//       ),
//     );
//   }
// }
//
// class CustomText extends StatelessWidget {
//   final String text;
//   final TextStyle textStyle;
//   final TextOverflow? overflow;
//
//   CustomText(
//       this.text,
//       this.textStyle, {
//         this.overflow = TextOverflow.ellipsis,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       overflow: overflow,
//       style: textStyle,
//     );
//   }
// }