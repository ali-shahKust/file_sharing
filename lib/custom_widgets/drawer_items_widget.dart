import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/bages/badge.dart';
import 'package:quick_backup/custom_widgets/bages/badge_position.dart';
import 'package:quick_backup/views/dashboard/upload_screen.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/user_name_setting/update_username.dart';
import '../utilities/pref_utills.dart';

class DrawerWidgetItems extends StatelessWidget {
  const DrawerWidgetItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/app_icon.png',
            //   height: SizeConfig.screenHeight! * 0.1,
            // ),
            PrimaryText(
              "Quick Backup",
              fontSize: SizeConfig.screenHeight! * 0.03,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.021,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, UpdateUserNameScreen.routeName);
                },
                child: customTile(Icons.edit_outlined, "Update Profile")),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, UploadingScreen.routeName, arguments: {"drawer": true});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.screenHeight! * 0.025,
                    horizontal: SizeConfig.screenWidth! * 0.02,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.015,
                      ),
                      Badge(
                        showBadge: Provider.of<DashBoardVm>(context).queue.length == 0 ? false : true,
                        // showBadge: true,

                        badgeContent: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1.0,
                            vertical: 1.0,
                          ),
                          child: PrimaryText(
                            '${Provider.of<DashBoardVm>(context).queue.length}',
                            // '100',
                            color: AppColors.kWhiteColor,
                            fontSize: SizeConfig.screenHeight! * 0.018,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        position: BadgePosition.topEnd(top: -20, end: -28),
                        // padding: EdgeInsets.symmetric(horizontal: 6),
                        badgeColor: AppColors.kBadgePeachColor,
                        child: PrimaryText(
                          "Uploading Queue",
                          color: Colors.white,
                          fontSize: SizeConfig.screenHeight! * 0.023,
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, DownloadScreen.routeName, arguments: {"drawer": true});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.list_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth! * 0.015,
                    ),
                    Badge(
                      showBadge: Provider.of<DownloadVm>(context).queue.length == 0 ? false : true,
                      // showBadge: true,

                      badgeContent: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 1.0,
                          vertical: 1.0,
                        ),
                        child: PrimaryText(
                          '${Provider.of<DownloadVm>(context).queue.length}',
                          // '0',
                          color: AppColors.kWhiteColor,
                          fontSize: SizeConfig.screenHeight! * 0.018,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      position: BadgePosition.topEnd(top: -20, end: -28),
                      // padding: EdgeInsets.symmetric(horizontal: 6),
                      badgeColor: AppColors.kBadgePeachColor,
                      child: PrimaryText(
                        "Downloading Queue",
                        color: Colors.white,
                        fontSize: SizeConfig.screenHeight! * 0.023,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            customTile(Icons.star_outline, "Rate App"),
            customTile(Icons.share_outlined, "Share App"),
            customTile(Icons.shield_outlined, "Privacy Policy"),
            InkWell(
              onTap: () {
                PreferenceUtilities.clearAllPrefs(context);
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
              },
              child: customTile(Icons.login_outlined, "Logout"),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTile(icon, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: SizeConfig.screenWidth! * 0.025,
          ),
          PrimaryText(
            title,
            color: Colors.white,
            fontSize: SizeConfig.screenHeight! * 0.023,
          )
        ],
      ),
    );
  }
}
