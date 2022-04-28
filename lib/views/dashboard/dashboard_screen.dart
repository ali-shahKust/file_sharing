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

import '../../data/services/auth_services.dart';
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
      refreshToken();
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        getPermissionStatus().then((permission) => {
              if (permission)
                {
                  Provider.of<CoreVm>(context, listen: false).checkSpace(),
                  Provider.of<CategoryVm>(context, listen: false).getDeviceFileManager(),
                }
            });

        // Provider.of<CategoryVm>(context, listen: false).fetchAllListLength();
        // Provider.of<DocumentVm>(context, listen: false).getTextFile();
      });
    });

    super.initState();
  }

  refreshToken() async {
    await AuthService.refreshSession();

  }

  // void fetchFileManagerData(){
  //   if()
  // }


  Future<bool> getPermissionStatus() async {
    PermissionStatus status = osVersion! >= 11 ? await Permission.manageExternalStorage.status : await Permission.storage.status;
    return status.isGranted;
  }

  Future<void> checkVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      osVersion = int.parse(androidInfo.version.release);

    }
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.screenHeight!;
    double width = SizeConfig.screenWidth!;
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
                            padding: const EdgeInsets.symmetric(vertical: 58.0, horizontal: 12),
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
                              child: iUtills().upperRoundedContainer(context, width, height * 0.476,
                                  color: AppColors.kPrimaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            PrimaryText(
                                              "Files Backup",
                                              fontSize: 26,
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
                                            if (!status.isGranted) {
                                              vm.permissionCheck(parentContext, osVersion, status);
                                            } else {
                                              if(vm.queue.isEmpty){
                                                Navigator.pushNamed(parentContext!, FileManagerHome.routeName);
                                              }
                                              else {
                                                showDialog(context: context, builder: (BuildContext dialogContext){
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text("Info!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                                                        SizedBox(height: 15,),
                                                        Text("Uploading Already in progress.",style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                                                        Text("Do you want to view the progress ?",style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
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

                                          child: customTile(icon: AppConstants.quick_backup_icon, title: "Quick Backup"),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, CloudItemsScreen.routeName);
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
