import 'package:flutter/material.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';

import '../../../constants/app_colors.dart';

class PageThreeScreen extends StatelessWidget {
  const PageThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Image.asset(AppConstants.on_boarding_page_three),
        SizedBox(height: SizeConfig.screenHeight! *0.035,),

        PrimaryText(
          "Backup & Restore\nYour Memories",
          textAlign: TextAlign.center,
          fontSize: SizeConfig.screenHeight! * 0.026,
          color: AppColors.kBlackColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * 0.014,
        ),
        PrimaryText(
          "Backup Important Data To Keep\nIt Safe And Restore It, When It’s\nGone To Be Deleted.",
          textAlign: TextAlign.center,
          fontSize: SizeConfig.screenHeight! * 0.020,
          color: Color(0xff959595),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
