import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/bages/badge.dart';
import 'package:quick_backup/custom_widgets/upload_screen.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/user_name_setting/update_username.dart';

import '../constants/app_constants.dart';
import '../utilities/i_utills.dart';
import '../utilities/pref_utills.dart';

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
            PrimaryText(
              "Quick Backup App",
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            customTile(Icons.star, "Rate App"),
            customTile(Icons.share, "Share App"),
            customTile(Icons.shield, "Privacy Policy"),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, UploadingScreen.routeName,
                      arguments: {"drawer": true});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 10),
                  child: Row(
                    children: [
                      Badge(
                        showBadge:
                            Provider.of<DashBoardVm>(context).queue.length == 0
                                ? false
                                : true,
                        badgeContent: PrimaryText(
                          '${Provider.of<DashBoardVm>(context).queue.length}',
                          color: AppColors.kAvatarRed,
                        ),
                        child: Icon(
                          Icons.list,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      PrimaryText(
                        "Uploading Queue",
                        color: Colors.white,
                        fontSize: 19,
                      )
                    ],
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, DownloadScreen.routeName,
                    arguments: {"drawer": true});
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                child: Row(
                  children: [
                    Badge(
                      showBadge:
                          Provider.of<DashBoardVm>(context).queue.length == 0
                              ? false
                              : true,
                      badgeContent: PrimaryText(
                        '${Provider.of<DashBoardVm>(context).queue.length}',
                        color: AppColors.kAvatarRed,
                      ),
                      child: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    PrimaryText(
                      "Downloading Queue",
                      color: Colors.white,
                      fontSize: 19,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, UpdateUserNameScreen.routeName);
                },
                child: customTile(Icons.edit, "Update Profile")),
            InkWell(
                onTap: () {
                  PreferenceUtilities.clearAllPrefs();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
                child: customTile(Icons.login, "Logout")),
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
            width: 15,
          ),
          PrimaryText(
            title,
            color: Colors.white,
            fontSize: 19,
          )
        ],
      ),
    );
  }
}
