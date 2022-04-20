import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/user_name_setting/user_name_setting_vm.dart';

import '../../utilities/pref_utills.dart';

class UserNameSettingScreen extends StatelessWidget {
  static const routeName = 'user_name';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNameSettingVm>(builder: (context, vm, _) {
      return Scaffold(
        body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AppConstants.username_background),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryText(
                  "Login",
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.038,
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! * 0.078,
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor.withOpacity(0.38),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: TextField(
                      controller: vm.userName,
                      style: TextStyle(
                          fontFamily: "AvenirNextLTPro",
                          color: Colors.white,
                          fontSize: SizeConfig.screenHeight! * 0.025,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.194,
                      vertical: 25),
                  child: InkWell(
                    onTap: () {},
                    child: iUtills().gradientButton(
                      height: SizeConfig.screenHeight! * 0.064,
                      width: SizeConfig.screenWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          PreferenceUtilities.setUserNameToPrefs(
                              vm.userName.text, context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, DashBoardScreen.routeName, (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text('Done'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
