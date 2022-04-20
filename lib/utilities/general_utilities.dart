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
}
