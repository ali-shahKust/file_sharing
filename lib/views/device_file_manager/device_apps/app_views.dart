//
//
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/custom_widgets/upload_screen.dart';
import 'package:quick_backup/data/models/app_model.dart';
import 'package:quick_backup/utilities/general_utilities.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';

class AppViews extends StatelessWidget {
  static const routeName = 'apps';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (BuildContext context, CategoryVm provider, Widget? child) {
        print('app list length is ${provider.appList.length}');
        return Scaffold(
          backgroundColor: AppColors.kPrimaryPurpleColor,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryPurpleColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/container_background.webp'),
                  )
                  // Image.asset('assets/container_background.svg'),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: SizeConfig.screenHeight! * 0.024,
                              color: Colors.white,
                            )),
                        PrimaryText(
                          "Apps",
                          fontSize: SizeConfig.screenHeight! * 0.028,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.050,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${provider.selectedFiles.length} Selected',
                          style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.024, color: AppColors.kWhiteColor),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.3,
                        ),
                        IconButton(
                          onPressed: () {
                            provider.changeIsAllAppsSelected();
                            !provider.isAllAppsSelected
                                ? provider.unSelectAllAppInList(provider.appList)
                                : provider.selectAllAppInList(provider.appList);
                            // provider.selectAllAppInList(provider.appList);
                          },
                          icon: Icon(
                            provider.isAllAppsSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight! * 0.82,
                    decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenHeight! * 0.02,
                              right: SizeConfig.screenHeight! * 0.02,
                              top: SizeConfig.screenHeight! * 0.04),
                          child: provider.loading == true
                              ? GeneralUtilities.LoadingFileWidget()
                              : GridView.builder(
                                  addAutomaticKeepAlives: false,
                                  addRepaintBoundaries: false,
                                  reverse: false,
                                  cacheExtent: 50,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 7.0,
                                  ),
                                  itemCount: provider.appList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    Application app = provider.appList[index].apps;

                                    return GestureDetector(
                                      onTap: () {
                                        provider.changeIsSelectedApp(index, provider.appList);
                                        if (provider.appList[index].isSelected) {
                                          provider.addToSelectedList = File(provider.appList[index].apps.apkFilePath);
                                        } else {
                                          provider.removeFromSelectedList =
                                              File(provider.appList[index].apps.apkFilePath);
                                        }
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: SizeConfig.screenHeight! * 0.05,
                                              left: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.kAppsCardLighColor,
                                                    border: Border.all(
                                                      // AppColors.avatarBgColors[GeneralUtilities.getRandomNumber(0, 7)],
                                                      //                                               borderRadius: BorderRadius.circular(50),
                                                      //                                             ),
                                                      color: AppColors
                                                          .avatarBgColors[GeneralUtilities.getRandomNumber(0, 7)],
                                                      width: 1.5,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                                height: SizeConfig.screenHeight! * 0.155,
                                                width: SizeConfig.screenWidth! * 0.44,
                                                child: Padding(
                                                  padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: SizeConfig.screenHeight! * 0.06,
                                                      ),
                                                      PrimaryText(
                                                        app.appName,
                                                            color: AppColors.kBlackColor,
                                                            fontSize: SizeConfig.screenHeight! * 0.023,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: SizeConfig.screenHeight! * 0.02,
                                              child: Container(
                                                height: SizeConfig.screenHeight! * 0.1,
                                                width: SizeConfig.screenWidth! * 0.22,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.avatarBgColors[GeneralUtilities.getRandomNumber(0, 7)],
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                  child: app is ApplicationWithIcon
                                                      ? Image.memory(app.icon,
                                                          height: SizeConfig.screenHeight! * 0.13,
                                                          width: SizeConfig.screenWidth! * 0.13)
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            provider.appList[index].isSelected
                                                ? Positioned(
                                                    top: SizeConfig.screenHeight! * -0.002,
                                                    right: 0,
                                                    child: Container(
                                                      height: SizeConfig.screenHeight! * 0.1,
                                                      width: SizeConfig.screenWidth! * 0.07,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle, color: AppColors.kPrimaryPurpleColor),
                                                      child: Padding(
                                                          padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.005),
                                                          child: Icon(
                                                            Icons.check,
                                                            size: SizeConfig.screenHeight! * 0.02,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 2.0,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                        Visibility(
                          visible: provider.selectedFiles.length > 0 ? true : false,
                          child: Positioned(
                            bottom: SizeConfig.screenHeight! * 0.012,
                            left: SizeConfig.screenWidth! * 0.005,
                            right: SizeConfig.screenWidth! * 0.005,
                            child: BackupButton(
                              text: '${AppStrings.backup}',
                              width: SizeConfig.screenWidth! * 0.58,
                              onTap: () async {
                                //  pd.show(max: 100, msg: 'File Uploading...');
                                if (provider.selectedFiles.length > 0) {
                                  Navigator.pushNamed(context, UploadingScreen.routeName,
                                      arguments: {'files': provider.selectedFiles, "drawer": false}).whenComplete(() {
                                    print('whencomplete call...');
                                    // provider.selectedFiles.clear();
                                    // provider.clearAllSelectedLists();
                                  });
                                }
                              },
                              btnColor: AppColors.kGreyColor,
                              padding: SizeConfig.screenHeight! * 0.02,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppGridItems extends StatelessWidget {
  final Application app;
  final provider;
  final int index;
  var onTap;

  AppGridItems({required this.app, required this.provider, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: SizeConfig.screenHeight! * 0.6,
        // color: Colors.orange,

        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.kAppsCardLighColor,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: SizeConfig.screenHeight! * 0.16,
                width: SizeConfig.screenWidth! * 0.44,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.06,
                      ),
                      Text(
                        app.appName,
                        style: TextStyle(color: AppColors.kBlackColor, fontSize: SizeConfig.screenHeight! * 0.023),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 20,
              child: Container(
                height: SizeConfig.screenHeight! * 0.1,
                width: SizeConfig.screenWidth! * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryPurpleColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                // child: Center(
                //   child: app is ApplicationWithIcon
                //       ? Image.memory(app.icon,
                //       height: SizeConfig.screenHeight!*0.1, width: SizeConfig.screenWidth!*0.1)
                //       : null,
                // ),
              ),
            ),
            provider.appList[index].isSelected
                ? Positioned(
                    top: SizeConfig.screenHeight! * -0.002,
                    right: 0,
                    child: Container(
                      height: SizeConfig.screenHeight! * 0.1,
                      width: SizeConfig.screenWidth! * 0.07,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryPurpleColor),
                      child: Padding(
                          padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.005),
                          child: Icon(
                            Icons.check,
                            size: SizeConfig.screenHeight! * 0.02,
                            color: Colors.white,
                          )),
                    ),
                  )
                : SizedBox(
                    height: 2.0,
                  ),
          ],
        ),

        // child: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Stack(children: [
        //     SizedBox(
        //       height: SizeConfig.screenHeight! * 0.3,
        //       child: Card(
        //         color:Colors.red,
        //         shape: RoundedRectangleBorder(
        //           // side: BorderSide(color: Colors.white70, width: 1),
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //       ),
        //     )
        //
        //
        //   ],),
        // ),
      ),
    );
  }
}
