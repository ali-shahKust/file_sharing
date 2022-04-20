import 'dart:async';
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
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

   showMessage({
    required BuildContext context,
    required String text,
  }) {
    return Flushbar(
      title: "Success",
      message: "Username updated successfully.",
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(colors: [  Color(0xffFFA37C),
        Color(0xffFE7940),
        Color(0xffFF9A70),]),
    )..show(context);
  }


  exitPopUp(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Container(
                width: SizeConfig.screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.03,
                    ),
                    Image.asset(
                      AppConstants.exit_logo,
                      width: SizeConfig.screenWidth! * 0.5,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.03,
                    ),
                    PrimaryText("Are your Sure you want to go back?"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 0.057,
                          width: SizeConfig.screenWidth! * 0.3,
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                  color: AppColors.kPrimaryColor)),
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: PrimaryText(
                                  'Cancel',
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: SizeConfig.screenHeight! * 0.025,
                                ),
                              )),
                        ),
                gradientButton(
                  height: SizeConfig.screenHeight! * 0.057,
                  width: SizeConfig.screenWidth! * 0.3,
                  child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
                        },
                        child: PrimaryText(
                          'Yes',
                          color: AppColors.kWhiteColor,
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig.screenHeight! * 0.025,
                        ),
                      )),
                ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.17,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

double getScreenWidth(context) => MediaQuery.of(context).size.width;

double getScreenHeight(context) => MediaQuery.of(context).size.height;
