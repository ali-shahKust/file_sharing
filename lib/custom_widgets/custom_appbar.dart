import 'package:flutter/material.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  var onTap;
   CustomAppBar({required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_back_ios,
                size: SizeConfig.screenHeight! * 0.024,
                color: Colors.white,
              )),
          PrimaryText(
            title,
            fontSize: SizeConfig.screenHeight! * 0.028,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            width: SizeConfig.screenWidth! * 0.050,
          )
        ],
      ),
    );
  }
}
