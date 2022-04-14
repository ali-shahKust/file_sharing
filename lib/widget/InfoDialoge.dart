import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/constants/app_colors.dart';

import 'dialoge_button.dart';

class InfoDialoge extends StatelessWidget {
  final String headingText;
  final String subHeadingText;
  final String btnText;
  final Function onBtnTap;

  InfoDialoge({required this.headingText, required this.subHeadingText, required this.btnText, required this.onBtnTap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          padding: EdgeInsets.only(
            top: size.height * 0.015,
            bottom: size.height * 0.01,
            left: size.width * 0.02,
            right: size.width * 0.015,
          ),
          height: size.height * 0.35,
          width: size.width * 0.85,
          // Change as per your requirement
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.12,
                    ),
                    Icon(
                      Icons.info,
                      size: size.height * 0.06,
                      color: AppColors.kWhiteColor,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: AppColors.kGreyColor,
                          size: size.height * 0.035,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                Text(
                  // "QR not Avaliable",
                  headingText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 1,
                    fontSize: size.height * 0.025,
                    color: AppColors.kBlackColor,
                  ),
                ),
                Text(
                  // "It's seems to be a extracted file you can't share such file via QR",
                  subHeadingText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 1,
                    fontSize: size.height * 0.02,
                    color: AppColors.kGreyColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                DialogeButton(
                  // text: 'OK',
                  text: btnText,
                  width: size.width * 0.32,
                  padding: size.height * 0.012,
                  onTap: onBtnTap,
                  btnColor: AppColors.kBlueColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
