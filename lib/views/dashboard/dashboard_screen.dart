import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/InfoDialoge.dart';
import 'package:quick_backup/custom_widgets/queues_screen.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/custom_widgets/primary_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';
import 'package:quick_backup/views/local_backup/backup_files.dart';

import '../online_backup/files_list.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = 'dash_board';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var osVersion;
  BuildContext? parentContext;

  void checkVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      // var release = androidInfo.version.release;
      osVersion = androidInfo.version.release;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.screenHeight!;
    double width = SizeConfig.screenWidth!;
    parentContext = context;
    return Consumer<DashBoardVm>(
      builder: (context, vm, _) => Scaffold(
        drawer: Drawer(
          child: Center(
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, QuesScreen.routeName);
                },
                child: const Text('Queue')),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
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
                Align(
                    alignment: Alignment.bottomCenter,
                    child: iUtills()
                        .upperRoundedContainer(context, width, height * 0.476))
              ],
            ),
          ),
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
