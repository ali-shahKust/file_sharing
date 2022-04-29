import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/custom_widgets/loading_widget.dart';

class GeneralUtilities {
  static Widget noDataFound() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/no_data_found.svg'),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.02,
            ),
            Text(
              'No Data Found',
              style: TextStyle(
                  fontSize: SizeConfig.screenHeight! * 0.025,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlackColor),
            ),
          ],
        ),
      ),
    );
  }

  static  Widget LoadingFileWidget(){
    return Container(
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius:
          BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             LoadingWidget(),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.03,
              ),
              Text(
                'Getting Files',
                style: TextStyle(
                    color: AppColors.kBlackColor, fontSize: SizeConfig.screenHeight! * 0.023),
              ),
            ],
          )),
    );
  }
  static String getFileName(String fileKey) {
    var fileName = fileKey.split('/');
    if(fileName!=null){
      if(fileName.contains('base.apk')){
        var  appFileName = fileName[fileName.length-2].split('-').first+'.apk';
        return appFileName;
      }
      else{
        return fileName.last;
      }

    }
    else{
      return fileKey;
    }

  }
  static int getRandomNumber(min, max) {
    Random random = Random();
    random = Random();
    int randomNumber = min + random.nextInt(max - min);
    return randomNumber;
  }


  static Widget miniLoader(Color color) {
    return Container(
      height: SizeConfig.screenHeight! * 0.028,
      width: SizeConfig.screenWidth! *0.06,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 2.0,
      ),
    );
  }
}
