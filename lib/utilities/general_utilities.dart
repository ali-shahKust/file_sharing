import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';

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
  static String getFileName(String fileKey) {
    var fileName = fileKey.split('/');
    if(fileName!=null){
      if(fileName.contains('base.apk')){
        var  appFileName = fileName[fileName.length-2].split('-').first+'.apk';
        print('final app name is $appFileName');
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
    debugPrint("$randomNumber is in the range of $min and $max");
    return randomNumber;
  }
}
