import 'package:flutter/material.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';

import '../constants/app_constants.dart';
import '../utilities/i_utills.dart';

class DrawerWidgetItems extends StatelessWidget {
  const DrawerWidgetItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText("Quick Backup App",fontSize: 28,fontWeight: FontWeight.w700,),
            customTile(Icons.star, "Rate App"),
            customTile(Icons.share, "Share App"),
            customTile(Icons.shield, "Privacy Policy"),
            customTile(Icons.edit, "Update Profile"),
            customTile(Icons.login, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget customTile(icon, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white,),
          SizedBox(width: 15,),
          PrimaryText(title, color: Colors.white,fontSize: 19 ,)
        ],
      ),
    );
  }
}
