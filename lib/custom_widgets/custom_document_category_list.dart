import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';

class CustomDocumentCategoryList extends StatelessWidget {
  final icon;
  final String type;
  final Color color;
  final String isSelected;
  final onTap;

  const CustomDocumentCategoryList(
      {Key? key,
        required this.icon,
        required this.type,
        required this.color,
        required this.isSelected,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.015, vertical: SizeConfig.screenHeight! * 0.014),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: onTap,
            child: Container(
                padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.032),
                decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      color:color.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ] ,
                  border: Border.all(
                    color: color,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected=='1'?color.withOpacity(0.4):Colors.white70
                ),
                height: SizeConfig.screenHeight! * 0.1,
                width: SizeConfig.screenWidth! * 0.2,
                // fixed width and height
                // SizeConfig.screenHeight!*0.05
                child: SvgPicture.asset(
                  icon,
                  // height: 70,
                  // width: 20,
                  fit: BoxFit.contain,
                )),
          ),
          SizedBox(height: SizeConfig.screenHeight!*0.01,),
          Text(
            type,
            style: TextStyle(
                color: AppColors.kBlackColor,
                fontSize: SizeConfig.screenHeight! * 0.022  ,
                fontWeight: FontWeight.w600),
          ),
          // CircleAvatar(
          //   radius: 20,
          //   backgroundImage: AssetImage('assets/avatar1.jpg'),
          // ),

        ],
      ),
    );
  }
}
