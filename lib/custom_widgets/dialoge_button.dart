import 'package:flutter/material.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';

class DialogeButton extends StatelessWidget {
  final String text;
  var onTap;
  final double width;
  final double padding;
  final Color btnColor;

  DialogeButton({required this.text, this.onTap, required this.width, required this.padding, required this.btnColor});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            Color(0xff7266F8),
            Color(0xff5043D8),
          ])),
      height: SizeConfig.screenHeight! * 0.057,
      width: SizeConfig.screenWidth! * 0.3,
      child: Center(
          child: InkWell(
            onTap: onTap,
            child: PrimaryText(
              'Ok',
              color: AppColors.kWhiteColor,
              fontWeight: FontWeight.normal,
              fontSize: SizeConfig.screenHeight! * 0.025,
            ),
          )),
    );
    // return InkWell(
    //   onTap: onTap,
    //   child:
    //   // Center(
    //   //   child: Container(
    //   //     decoration: BoxDecoration(
    //   //       color: btnColor != null ? btnColor : AppColors.kGreyColor,
    //   //       borderRadius: BorderRadius.all(Radius.circular(20)),
    //   //       // boxShadow: [
    //   //       //   BoxShadow(color: Colors.grey[300], spreadRadius: 0.0, blurRadius: 10),
    //   //       // ],
    //   //     ),
    //   //     width: width,
    //   //     child: Padding(
    //   //       padding: EdgeInsets.all(padding != null ? padding : screenWidth * 0.058),
    //   //       child: Text(
    //   //         text,
    //   //         style: TextStyle(
    //   //           fontFamily: 'Product_Sans',
    //   //           fontWeight: FontWeight.bold,
    //   //           color: AppColors.kWhiteColor,
    //   //           fontSize: screenHeight * 0.024,
    //   //         ),
    //   //         textAlign: TextAlign.center,
    //   //       ),
    //   //     ),
    //   //   ),
    //   // ),
    // );
  }
}
