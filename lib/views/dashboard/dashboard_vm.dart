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
import 'package:provider/provider.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/local_db/database_helper.dart';
import 'package:quick_backup/custom_widgets/queues_screen.dart';
import 'package:quick_backup/utilities/pref_provider.dart';

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
}
