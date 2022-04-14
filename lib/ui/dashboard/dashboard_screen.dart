import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/views/file_manager_views/filemanager_home.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:glass_mor/widget/InfoDialoge.dart';
import 'package:glass_mor/widget/queues_screen.dart';
import 'package:glass_mor/ui/local_backup/backup_files.dart';

import 'package:glass_mor/utills/i_utills.dart';
import 'package:glass_mor/widget/primary_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../online_backup/files_list.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = 'dash_board';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var osVersion;
  BuildContext ?parentContext;
  void checkVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      // var release = androidInfo.version.release;
      osVersion = androidInfo.version.release;
    }
  }
  @override
  Widget build(BuildContext context) {
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
                iUtills.glassContainer(
                    context: context,
                    width: getScreenWidth(context),
                    height: getScreenHeight(context) * 0.43,
                    child: const Center(
                      child: Text(
                        "There will Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async{
                                print('I am button tap....');
                                PermissionStatus status = osVersion == '11'
                                    ? await Permission.manageExternalStorage.status
                                    : await Permission.storage.status;
                                print('storage permission status is ${status.index}');
                                if (!status.isGranted) {
                                  // InfoDialoge();
                                  showDialog(
                                      barrierDismissible: true,
                                      context: parentContext!,
                                      builder: (context) {
                                        return InfoDialoge(
                                          headingText: 'Storage Permission Needed',
                                          subHeadingText:
                                          'This App require storage permission to share and receive files',
                                          btnText: 'Ok',
                                          onBtnTap: () async {
                                            Navigator.pop(context);
                                            if (osVersion == '11') {
                                              status = await Permission.manageExternalStorage.status;
                                            } else {
                                              status = await Permission.storage.status;
                                            }
                                            // PermissionStatus status = osVersion == '11'? await Permission.manageExternalStorage.status:Permission.storage.status;
                                            print('manage external storage permission status is ...$status');
                                            if (status.isGranted) {
                                              // Dialogs.showToast('Permission granted...');
                                              // vm.pickFile(context: context);
                                              Navigator.pushNamed(context, FileManagerHome.routeName);

                                            } else if (status.isDenied) {
                                              PermissionStatus status = osVersion == '11'
                                                  ? await Permission.manageExternalStorage.request()
                                                  : await Permission.storage.request();
                                              print(
                                                  'manage external storage permission status in denied condition is ...$status');
                                              // Dialogs.showToast('Please Grant Storage Permissions');
                                              // PermissionStatus status = await Permission.manageExternalStorage.request();
                                            } else if (status.isRestricted) {
                                              // AppSettings.openAppSettings();
                                              print('Restricted permission call');
                                              PermissionStatus status = osVersion == '11'
                                                  ? await Permission.manageExternalStorage.request()
                                                  : await Permission.storage.request();
                                              print(
                                                  'manage external storage permission status in restricted condition is ...$status');
                                              // Dialogs.showToast('Please Grant Storage Permissions');
                                              // PermissionStatus status = await Permission.manageExternalStorage.request();
                                            } else {
                                              print('else condition permission call');
                                              PermissionStatus status = osVersion == '11'
                                                  ? await Permission.manageExternalStorage.request()
                                                  : await Permission.storage.request();

                                              print(
                                                  'manage external storage permission status in denied condition is ...$status');
                                              // Dialogs.showToast('Please Grant Storage Permissions');
                                            }
                                            // print('I am in no permission granted with status $status');
                                            // ShareFilesUtils.requestPermission(context, NewFileManager());
                                          },
                                        );
                                      });
                                } else {
                                  print('I am in  permission granted with status $status');
                                  print('going to home with permission status $status');
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => FileManagerHome()));
                                  // Navigator.pushNamed(context, FileManagerHome.routeName);
                                  // vm.pickFile(context: context);
                                }
                                // Navigator.pushNamed(
                                //     context, PicturesScreen.routeName);

                                // vm.pickFile(context: context);
                              },
                              child: iUtills.glassContainer(
                                  context: context,
                                  width: getScreenWidth(context) / 2.5,
                                  height: getScreenHeight(context) * 0.1833,
                                  child: Center(
                                      child: PrimaryText(
                                    'Send File',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ))),
                            ),
                            InkWell(
                              onTap: () async{
                                Navigator.pushNamed(
                                        context, PicturesScreen.routeName);
                                // Navigator.pushNamed(
                                //     context, PicturesScreen.routeName);

                                // vm.pickFile(context: context);
                              },
                              child: iUtills.glassContainer(
                                  context: context,
                                  width: getScreenWidth(context) / 2.5,
                                  height: getScreenHeight(context) * 0.1833,
                                  child: Center(
                                      child: PrimaryText(
                                    'Receive File',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ))),
                            ),

                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, BackupFilesScreen.routeName);
                          },
                          child: iUtills.glassContainer(
                              context: context,
                              width: getScreenWidth(context) / 2.5,
                              height: getScreenHeight(context) * 0.1833,
                              child: Center(
                                  child: PrimaryText(
                                    'Backup files',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}
