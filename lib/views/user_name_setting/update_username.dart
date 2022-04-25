import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/user_name_setting/user_name_setting_vm.dart';

import '../../utilities/pref_utills.dart';

class UpdateUserNameScreen extends StatelessWidget {
  static const routeName = 'update_user_name';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNameSettingVm>(builder: (context, vm, _) {
      vm.getUserName(context);
      return Scaffold(
        body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AppConstants.username_background),
            fit: BoxFit.cover,
          )),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Align(
                  alignment: Alignment.center,
                  child: PrimaryText(
                    "Profile",
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    iUtills().upperRoundedContainer(context, SizeConfig.screenWidth, SizeConfig.screenHeight! * 0.328,
                        color: AppColors.kWhiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 15).copyWith(bottom: 4),
                              child: PrimaryText(
                                "Username",
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight! * 0.078,
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                                  child: TextField(
                                    controller: vm.userName,
                                    style: TextStyle(
                                        fontFamily: "AvenirNextLTPro",
                                        color: Colors.grey,
                                        fontSize: SizeConfig.screenHeight! * 0.025,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // InkWell(
                                  //   onTap: () {},
                                  //   child: Container(
                                  //     height: SizeConfig.screenHeight! * 0.064,
                                  //     width: SizeConfig.screenWidth! * 0.366,
                                  //     decoration: BoxDecoration(
                                  //         border: Border.all(
                                  //             color: AppColors.kPrimaryColor),
                                  //         borderRadius: BorderRadius.circular(16)),
                                  //     child: ElevatedButton(
                                  //       onPressed: () {
                                  //
                                  //       },
                                  //       style: ElevatedButton.styleFrom(
                                  //           primary: Colors.transparent,
                                  //           shadowColor: Colors.transparent),
                                  //       child: PrimaryText(
                                  //         'Logout',
                                  //         color: AppColors.kPrimaryColor,
                                  //         fontSize: 24,
                                  //         fontWeight: FontWeight.w600,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {},
                                    child: iUtills().gradientButton(
                                      height: SizeConfig.screenHeight! * 0.064,
                                      width: SizeConfig.screenWidth! * 0.366,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          PreferenceUtilities.setUserNameToPrefs(vm.userName.text, context);
                                          iUtills().showMessage(context: context, text: "Name Updated");
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent, shadowColor: Colors.transparent),
                                        child: Text('Update'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
              )
            ],
          ),
        ),
      );
    });
  }
}
