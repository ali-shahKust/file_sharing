import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final leadingIcon;
  final leadingColorDark;
  final leadingColorLight;
  final String title;
  final String subtitleFileLenght;
  final String subtitleFileSize;

  // final traling;
  final onTap;

  const CustomListTile(
      {Key? key,
      required this.leadingIcon,
      required this.leadingColorDark,
      required this.leadingColorLight,
      required this.title,
      required this.subtitleFileLenght,
      required this.subtitleFileSize,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.015, vertical: SizeConfig.screenHeight! * 0.014),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.032),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.05, 0.4],
                  colors: [
                    leadingColorLight,
                    leadingColorDark,
                  ],
                ),
              ),
              height: SizeConfig.screenHeight! * 0.1,
              width: SizeConfig.screenWidth! * 0.2,
              // fixed width and height
              // SizeConfig.screenHeight!*0.05
              child: SvgPicture.asset(
                leadingIcon,
                // height: 70,
                // width: 20,
                fit: BoxFit.contain,
              )),
          // CircleAvatar(
          //   radius: 20,
          //   backgroundImage: AssetImage('assets/avatar1.jpg'),
          // ),
          Expanded(
            flex: 14,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.05),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          color: AppColors.kBlackColor,
                          fontSize: SizeConfig.screenHeight! * 0.024,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.02,
                    ),
                    RichText(
                      textScaleFactor: 1.2,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(text: subtitleFileLenght + "   ", style: TextStyle(color: AppColors.kGreyColor)),
                          TextSpan(
                            text: "●  " + subtitleFileSize,
                            style: TextStyle(fontWeight: FontWeight.bold, color: leadingColorDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: InkWell(
                  onTap: onTap, child: SvgPicture.asset('assets/file_manager_assets/filemanager_home_forward.svg'))),
        ],
      ),
    );
  }
}
