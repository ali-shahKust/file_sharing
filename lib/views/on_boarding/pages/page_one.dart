import 'package:flutter/material.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';

import '../../../constants/app_colors.dart';

class PageOneScreen extends StatelessWidget {
  const PageOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppConstants.on_boarding_page_one),
        PrimaryText(
          "Share Your Data By\nCloud Storage",
          textAlign: TextAlign.center,
          fontSize: SizeConfig.screenHeight! * 0.026,
          color: AppColors.kBlackColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * 0.014,
        ),
        PrimaryText(
          "Keep Data Safe On Cloud Storage\nAnd Share It To Friends.",
          textAlign: TextAlign.center,
          fontSize: SizeConfig.screenHeight! * 0.020,
          color: Color(0xff959595),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
