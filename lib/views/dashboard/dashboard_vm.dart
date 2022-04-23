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
import 'package:quick_backup/custom_widgets/queues_screen.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/core_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';

import '../../data/models/app_model.dart';
import '../../data/models/queue_model.dart';

int completed = 0;

class DashBoardVm extends BaseVm {
  var queue = GetIt.I.get<AppModel>().queue;

  List<File> _files = [];
  StreamSubscription? subscription;
  var dbHelper = GetIt.I.get<DatabaseHelper>();

  List<File> get files => _files;
  bool _connectionLost = false;

  bool get connectionLost => _connectionLost;

  set connectionLost(bool value) {
    _connectionLost = value;
    notifyListeners();
  }


  set files(List<File> value) {
    _files = value;
    notifyListeners();
  }


  checkConnection() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print("Connection name ${result.name}");

      if (result.name == 'none') {
        connectionLost = true;
      } else if (result.name == 'wifi') {
        connectionLost = false;
      } else if (result.name == 'mobile') {
        connectionLost = false;
      }
    });
  }
  pickFile({context}) async {

    var mfile = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (mfile != null && mfile.files.isNotEmpty) {
      files.clear();
      files = mfile.paths.map((path) => File(path!)).toList();

      // uploadFile(context, files);
      Navigator.pushNamed(context, QuesScreen.routeName,arguments: {"files":files,"drawer":false});
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>QuesScreen(files: files,),fullscreenDialog: true));

    }
  }


  Future<void>uploadFile(List<File> file,context) async {
    queue.clear();
    completed = 0;
    for (var element in file) {
      String filename = element.path.split('/').last;
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

    for (int i = 0; i < file.length; i++) {
      String filename = file[i].path.split('/').last;
      String _folderkey = mime(filename)!.split('/').first;
      print("MIME IS ${_folderkey}");
      String fileKey = _folderkey +"/" + filename;
      try {
        await Amplify.Storage.uploadFile(
            local: file[i],
            options: UploadFileOptions(accessLevel: StorageAccessLevel.protected),
            key: fileKey,
            onProgress: (progress) async {
              queue[i]!.progress =
                  (progress.getFractionCompleted() * 100).round().toString();
              notifyListeners();
              print("XXPROGRESS: ${queue[i]!.progress}");

              queue[i]!.id = i;
                  (progress.getFractionCompleted() * 100).round().toString();
              if ((progress.getFractionCompleted() * 100).round() == 100) {
                completed = i + 1;
                queue[i]!.key = fileKey;
              }

            });
        int? count = await dbHelper.checkValue(queue[i]!.path);
        if (count != null && count > 0) {
          print("This file already exist");
        } else {
          dbHelper.insertFileToDb(queue[i]!);
        }
        notifyListeners();

      } on StorageException catch (e) {
        print(e.message);
      } catch (e) {
        print(e.toString());
      }
    }
  }
   permissionCheck(BuildContext ?parentContext,int ?osVersion,PermissionStatus status){
   return  showDialog(
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
              if (osVersion! >=11) {
                status = await Permission.manageExternalStorage.status;
              } else {
                status = await Permission.storage.status;
              }
              // PermissionStatus status = osVersion! >=11? await Permission.manageExternalStorage.status:Permission.storage.status;
              print('manage external storage permission status is ...$status');
              if (status.isGranted) {
                print('i am in premission granted....');
                // Dialogs.showToast('Permission granted...');
                Provider.of<CoreVm>(parentContext, listen: false).checkSpace();
                Provider.of<CategoryVm>(parentContext, listen: false).getDeviceFileManager();
                Provider.of<CategoryVm>(parentContext, listen: false).fetchAllListLength();
                Navigator.pushNamed(parentContext, FileManagerHome.routeName);
              }  if (status.isDenied) {
                print('I am permission denied.....');
                PermissionStatus status =osVersion >=11
                    ? await Permission.manageExternalStorage.request()
                    : await Permission.storage.request();
                Provider.of<CoreVm>(parentContext, listen: false).checkSpace();
                Provider.of<CategoryVm>(parentContext, listen: false).getDeviceFileManager();
                Provider.of<CategoryVm>(parentContext, listen: false).fetchAllListLength();
                print(
                    'manage external storage permission status in denied condition is ...$status');
                // Dialogs.showToast('Please Grant Storage Permissions');
                // PermissionStatus status = await Permission.manageExternalStorage.request();
              }  if (status.isRestricted) {
                // AppSettings.openAppSettings();
                print('Restricted permission call');
                PermissionStatus status = osVersion>=11
                    ? await Permission.manageExternalStorage.request()
                    : await Permission.storage.request();
                print(
                    'manage external storage permission status in restricted condition is ...$status');
                // Dialogs.showToast('Please Grant Storage Permissions');
                // PermissionStatus status = await Permission.manageExternalStorage.request();
              } else {
                print('else condition permission call');
                PermissionStatus status = osVersion >=11
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
  }
}
