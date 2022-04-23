import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/utilities/i_utills.dart';

import '../configurations/size_config.dart';
import '../views/dashboard/dashboard_screen.dart';
import 'app_text_widget.dart';

class CustomDialogBox extends StatefulWidget {
  final String? title, descriptions, text,screen;

  const CustomDialogBox({Key? key, this.title, this.descriptions, this.text,this.screen}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: AppConstants.padding,top: AppConstants.avatarRadius
              + AppConstants.padding, right: AppConstants.padding,bottom: AppConstants.padding
          ),
          margin: EdgeInsets.only(top: AppConstants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions!,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Container(
                      height: SizeConfig.screenHeight! * 0.057,
                      width: SizeConfig.screenWidth! * 0.3,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(colors: [
                            Color(0xff7266F8),
                            Color(0xff5043D8),
                          ])),
                      height: SizeConfig.screenHeight! * 0.057,
                      width: SizeConfig.screenWidth! * 0.3,
                      child: Center(
                          child: InkWell(
                            onTap: () {
                              if(widget.screen=="dashboard"){
                                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                              }else{
                                Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
                              }
                            },
                            child: PrimaryText(
                              'Yes',
                              color: AppColors.kWhiteColor,
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConfig.screenHeight! * 0.025,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: AppConstants.padding,
          right: AppConstants.padding,
          child: CircleAvatar(
            backgroundColor: AppColors.kPrimaryColor,
            radius: AppConstants.avatarRadius+1,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: AppConstants.avatarRadius,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(AppConstants.avatarRadius)),
                  child: Image.asset(AppConstants.exit_logo)
              ),
            ),
          ),
        ),
      ],
    );
  }
}