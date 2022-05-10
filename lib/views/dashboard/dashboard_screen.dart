import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/InfoDialoge.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/custom_dialog.dart';
import 'package:quick_backup/custom_widgets/drawer_items_widget.dart';
import 'package:quick_backup/views/dashboard/upload_screen.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/custom_widgets/primary_text.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';
import 'package:quick_backup/views/local_backup/backup_files.dart';
import 'package:quick_backup/views/online_backup/cloud_items_screen.dart';

import '../device_file_manager/category/category_vm.dart';
import '../device_file_manager/file_manager_home/core_vm.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = 'dash_board';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  BuildContext? parentContext;
  int? osVersion;

  final _advancedDrawerController = AdvancedDrawerController();
  final _controller = AdvancedDrawerController();

  Future<bool> _onWillPop() async {
    return (iUtills().exitPopUp(context, 'dashboard')) ?? false;
  }

  @override
  void initState() {
    checkVersion().then((value) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Provider.of<CoreVm>(context, listen: false).checkSpace();
        Provider.of<CategoryVm>(context, listen: false).getDeviceFileManager();
        // Provider.of<CategoryVm>(context, listen: false).fetchAllListLength();
        // Provider.of<DocumentVm>(context, listen: false).getTextFile();
      });
    });

    super.initState();
  }

  // void fetchFileManagerData(){
  //   if()
  // }

  Future<void> checkVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      // var release = androidInfo.version.release;
      osVersion = int.parse(androidInfo.version.release);
      // var sdkInt = androidInfo.version.sdkInt;
      // var manufacturer = androidInfo.manufacturer;
      // var model = androidInfo.model;
      // print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;
    parentContext = context;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Consumer<DashBoardVm>(
            builder: (context, vm, _) => AdvancedDrawer(
                  backdropColor: AppColors.kPrimaryColor,
                  controller: _advancedDrawerController,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  animateChildDecoration: true,
                  rtlOpening: false,
                  openScale: 0.55,
                  openRatio: 0.66,
                  disabledGestures: false,
                  childDecoration: const BoxDecoration(
                    // NOTICE: Uncomment if you want to add shadow behind the page.
                    // Keep in mind that it may cause animation jerks.
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 0.0,
                    //   ),
                    // ],
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  drawer: DrawerWidgetItems(),
                  child: Scaffold(
                    body: SizedBox(
                      width: getScreenWidth(context),
                      height: getScreenHeight(context),
                      child: Stack(
                        children: [
                          SizedBox(
                              width: getScreenWidth(context),
                              height: getScreenHeight(context),
                              child: Image.asset(
                                AppConstants.home_screen_background,
                                fit: BoxFit.cover,
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.08, horizontal: screenWidth * 0.05),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                  onTap: () {
                                    _advancedDrawerController.showDrawer();
                                  },
                                  child: SvgPicture.asset(AppConstants.drawer_icon)),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: iUtills().upperRoundedContainer(context, screenWidth, screenHeight * 0.476,
                                  color: AppColors.kPrimaryColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01,
                                      horizontal: screenWidth * 0.05,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            PrimaryText(
                                              "Files Backup",
                                              fontSize: screenHeight * 0.034,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                            SvgPicture.asset(AppConstants.cloud_icon)
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            PermissionStatus status =
                                                osVersion! >= 11 ? await Permission.manageExternalStorage.status : await Permission.storage.status;
                                            print('on tap permission status ....$status');
                                            if (!status.isGranted) {
                                              print('dialoge open...');
                                              vm.permissionCheck(parentContext, osVersion, status, false);
                                            } else {
                                              if (vm.queue.isEmpty) {
                                                Navigator.pushNamed(parentContext!, FileManagerHome.routeName);
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext dialogContext) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Info!",
                                                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              "Uploading Already in progress.",
                                                              style: TextStyle(fontSize: 14),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            Text(
                                                              "Do you want to view the progress ?",
                                                              style: TextStyle(fontSize: 14),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            SizedBox(
                                                              height: 22,
                                                            ),
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
                                                                        border: Border.all(color: AppColors.kPrimaryColor)),
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
                                                                        Navigator.pushNamed(context, UploadingScreen.routeName,
                                                                            arguments: {"drawer": true});
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
                                                      );
                                                    });
                                              }
                                            }
                                          },

                                          // Navigator.pushNamed(context, FileManagerHome.routeName);

                                          child: customTile(icon: AppConstants.quick_backup_icon, title: "Quick Backup"),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            PermissionStatus status =
                                                osVersion! >= 11 ? await Permission.manageExternalStorage.status : await Permission.storage.status;
                                            print('on tap permission status ....$status');
                                            if (!status.isGranted) {
                                              print('dialoge open...');
                                              vm.permissionCheck(parentContext, osVersion, status, true);
                                            } else if (status.isGranted) {
                                              Navigator.pushNamed(context, CloudItemsScreen.routeName);
                                            }
                                          },
                                          child: customTile(icon: AppConstants.restore_icon, title: "Restore Files"),
                                        ),
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ),
                )));
  }

  Widget customTile({icon, title}) {
    return iUtills().roundedContainer(
      context,
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight! * 0.125,
        color: Colors.white,
        child: Row(
          children: [
            SvgPicture.asset(icon),
            PrimaryText(
              title,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xff373737),
            ),
          ],
        ),
      ),
    );
  }
// @override
// void dispose() {
//
//   super.dispose();
// }
}
