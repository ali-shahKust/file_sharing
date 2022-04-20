

import 'package:flutter/material.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/utilities/custom_theme.dart';

class AppStyle {

  static const gradientDecoration =   const BoxDecoration(
    gradient:  LinearGradient(
        colors: [
          CustomTheme.primaryColor,
          CustomTheme.secondaryColor

        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        tileMode: TileMode.decal),
  );

  // static final onBoardingTextStyle = TextStyle(color: AppColors.kWhiteColor,fontSize: SizeConfig.screenHeight! * 0.035);
  //
  //
  // static final kTitleStyle = TextStyle(
  //     color: AppColors.kBlackColor,
  //     fontSize: SizeConfig.screenHeight! * 0.022,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: 'WorkSans');
  static final kStorageTextStyle =
  TextStyle(color: AppColors.kPrimaryColor, fontSize: SizeConfig.screenHeight! * 0.02,fontWeight: FontWeight.bold);
  //
  // static final kContainerTitleStyle = TextStyle(
  //     color: AppColors.kGreyColor,
  //     fontSize: SizeConfig.screenHeight! * 0.018,
  //     fontWeight: FontWeight.normal,
  //     fontFamily: 'WorkSans');
  // static final kContainerSubTitleStyle =
  // TextStyle(color: AppColors.kWhiteColor, fontSize: SizeConfig.screenHeight! * 0.0155, fontFamily: 'WorkSans');
  //
  // static final kHeadingTextStyle = TextStyle(
  //     color: AppColors.kWhiteColor,
  //     fontSize: SizeConfig.screenHeight! * 0.026,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: 'WorkSans');
  // static final kHeadingSubtitleStyle =
  // TextStyle(fontSize: SizeConfig.screenHeight! * 0.022, color: Colors.grey, fontFamily: 'WorkSans');
  //
  //
  //
  // // static final kBoldBlackStyle = TextStyle(
  // //     color: AppColors.kBlackColor,
  // //     fontSize: SizeConfig.screenHeight! * 0.026,
  // //     fontWeight: FontWeight.bold,
  // //     fontFamily: 'WorkSans');
  // static final kContainerBoxDecoration = BoxDecoration(
  //   color: AppColors.kGreyLightColor,
  //   borderRadius: BorderRadius.only(
  //     topLeft: Radius.circular(50),
  //     topRight: Radius.circular(50),
  //   ),
  // );
  // static final kButtonBoxDecoration = BoxDecoration(
  //     gradient: LinearGradient(
  //       //  begin: Alignment.centerLeft,
  //       // end: Alignment.centerRight,
  //       stops: [0.1, 0.4, 0.9],
  //       colors: [AppColors.kButtonFirstColor, AppColors.kButtonSecondColor, AppColors.kButtonThirdColor],
  //     ),
  //     borderRadius: BorderRadius.circular(50));
  // static final kCardBoxDecoration = BoxDecoration(
  //
  //     color: AppColors.kPrimaryLightBlackColor,
  //     borderRadius: BorderRadius.circular(15),
  //     border: Border.all(color: AppColors.kGreyColor, width: 0.2),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.black,
  //         blurRadius: 2.0,
  //         spreadRadius: 0.0,
  //         offset: Offset(2.0, 2.0), // shadow direction: bottom right
  //       )
  //     ],
  //
  // );
  // static final kRoundedContainerDecoration= BoxDecoration(
  //     color:AppColors.kPrimaryLightBlackColor,
  //     borderRadius: BorderRadius.all(
  //       Radius.circular(30.0),
  //     ));
  // static final  kDefaultShadow = BoxShadow(
  // offset: Offset(0, 15),
  // blurRadius: 27,
  // color: Colors.black12, // Black color with 12% opacity
  // );
}