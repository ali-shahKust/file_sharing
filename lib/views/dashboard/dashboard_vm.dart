import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mime_type/mime_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/custom_widgets/InfoDialoge.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/local_db/database_helper.dart';
import 'package:quick_backup/data/services/auth_services.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/core_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';
import 'package:quick_backup/views/online_backup/cloud_items_screen.dart';

import '../../data/models/app_model.dart';
import '../../data/models/queue_model.dart';
import '../../utilities/general_utilities.dart';

class DashBoardVm extends BaseVm {
  int completed = 0;

  DashBoardVm() {
    loader();
  }

  var queue = GetIt.I.get<AppModel>().queue;
  List<File> _files = [];
  StreamSubscription? subscription;

  // var dbHelper = GetIt.I.get<DatabaseHelper>();

  List<File> get files => _files;
  bool _connectionLost = false;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get connectionLost => _connectionLost;

  set connectionLost(bool value) {
    _connectionLost = value;
    notifyListeners();
  }

  set files(List<File> value) {
    _files = value;
    notifyListeners();
  }

  loader() async {
    isLoading = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
  }

  checkConnection() async {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!

      if (result.name == 'none') {
        connectionLost = true;
      } else if (result.name == 'wifi') {
        connectionLost = false;
      } else if (result.name == 'mobile') {
        connectionLost = false;
      }
    });
  }

  Future<void> uploadFile(List<File> file, context) async {
    await AuthService.refreshSession();
    isLoading = true;
    queue.clear();

    completed = 0;
    await Future.delayed(Duration(seconds: 2));
    for (var element in file) {
      String filename = GeneralUtilities.getFileName(element.path);
      String date = element.statSync().modified.toString();
      queue.add(QueueModel(
          id: null,
          name: filename,
          path: element.path,
          date: date,
          isSelected: '0',
          size: element.lengthSync().toString(),
          status: "pending",
          progress: "pending"));
    }
    isLoading = false;
    for (int i = 0; i < file.length; i++) {
      String filename = GeneralUtilities.getFileName(file[i].path);
      String _folderkey = mime(filename)!.split('/').first;
      if (mime(filename)!.split('/').first == "application") {
        if (mime(filename)!.split('/').last == "vnd.android.package-archive") {
          _folderkey = "application";
        } else {
          _folderkey = 'document';
        }
      } else {
        _folderkey = mime(filename)!.split('/').first;
      }
      String fileKey = _folderkey + "/" + filename;
      try {
        await Amplify.Storage.uploadFile(
            local: file[i],
            options: UploadFileOptions(accessLevel: StorageAccessLevel.protected),
            key: fileKey,
            onProgress: (progress) async {
              queue[i]!.progress = (progress.getFractionCompleted() * 100).round().toString();
              notifyListeners();
              queue[i]!.id = i;
              (progress.getFractionCompleted() * 100).round().toString();
              if ((progress.getFractionCompleted() * 100).round() == 100) {
                completed = i + 1;
                queue[i]!.key = fileKey;
              }
            });
        // int? count = await dbHelper.checkValue(queue[i]!.path);
        // if (count != null && count > 0) {
        //   print("This file already exist");
        // } else {
        //   dbHelper.insertFileToDb(queue[i]!);
        // }
        notifyListeners();
      } on StorageException catch (e) {
        debugPrint('Here is the StorageException in download_vm: $e');
        iUtills().showMessage(context: context, title: "Error", text: "Please Try again Later!");
        await Future.delayed(Duration(seconds: 3)).whenComplete(() => {
              Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false),
            });
      } catch (e) {
        debugPrint('Here is the StorageException in download_vm: $e');
        iUtills().showMessage(context: context, title: "Error", text: "Please Try again Later!");
        await Future.delayed(Duration(seconds: 3)).whenComplete(() => {
              Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false),
            });
      }
      if (completed != 0 && completed == queue.length) {
        queue.clear();
        completed = 0;
        iUtills().showMessage(context: context, title: "Completed", text: "Files uploaded successfully");
        await Future.delayed(Duration(seconds: 3)).whenComplete(() => {
              Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false),
            });

        notifyListeners();
      }
    }
  }

  permissionCheck(BuildContext? parentContext, int? osVersion, PermissionStatus status, bool isRestore) {
    return showDialog(
        barrierDismissible: true,
        context: parentContext!,
        builder: (context) {
          return InfoDialoge(
            headingText: 'Storage Permission Needed',
            subHeadingText: 'This App require storage permission to share and receive files',
            btnText: 'Ok',
            onBtnTap: () async {
              Navigator.pop(context);
              if (osVersion! >= 11) {
                status = await Permission.manageExternalStorage.status;
              } else {
                status = await Permission.storage.status;
              }
              // PermissionStatus status = osVersion! >=11? await Permission.manageExternalStorage.status:Permission.storage.status;
              if (status.isGranted) {
                // Dialogs.showToast('Permission granted...');
                Provider.of<CoreVm>(parentContext, listen: false).checkSpace();
                Provider.of<CategoryVm>(parentContext, listen: false).getDeviceFileManager();
                if (!isRestore) {
                  Navigator.pushNamed(parentContext, FileManagerHome.routeName);
                } else {
                  Navigator.pushNamed(context, CloudItemsScreen.routeName);
                }
              }
              if (status.isDenied) {
                PermissionStatus status = osVersion >= 11 ? await Permission.manageExternalStorage.request() : await Permission.storage.request();
                Provider.of<CoreVm>(parentContext, listen: false).checkSpace();
                Provider.of<CategoryVm>(parentContext, listen: false).getDeviceFileManager();
                // if(!isRestore){
                //
                //   // Provider.of<CategoryVm>(parentContext, listen: false).fetchAllListLength();
                // }
                // Provider.of<CategoryVm>(parentContext, listen: false).fetchAllListLength();

                // Dialogs.showToast('Please Grant Storage Permissions');
                // PermissionStatus status = await Permission.manageExternalStorage.request();
              }
              if (status.isRestricted) {
                // AppSettings.openAppSettings();

                PermissionStatus status = osVersion >= 11 ? await Permission.manageExternalStorage.request() : await Permission.storage.request();

                // Dialogs.showToast('Please Grant Storage Permissions');
                // PermissionStatus status = await Permission.manageExternalStorage.request();
              } else {
                PermissionStatus status = osVersion >= 11 ? await Permission.manageExternalStorage.request() : await Permission.storage.request();

                // Dialogs.showToast('Please Grant Storage Permissions');
              }
            },
          );
        });
  }
}
