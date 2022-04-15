import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/local_db/database_helper.dart';
import 'package:quick_backup/custom_widgets/queues_screen.dart';

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
      Navigator.pushNamed(context, QuesScreen.routeName,arguments: files);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>QuesScreen(files: files,),fullscreenDialog: true));

    }
  }


  uploadFile(List<File> file) async {
    queue.clear();
    completed = 0;
    for (var element in file) {
      String key = element.path.split('/').last;
      String date = element.statSync().modified.toString();

      queue.add(QueueModel(
          id: null,
          name: key,
          path: element.path,
          date: date,
          isSelected: '0',
          size: element.lengthSync().toString(),
          status: "pending",
          progress: "pending"));
    }

    for (int i = 0; i < file.length; i++) {
      String key = file[i].path.split('/').last;
      try {
        await Amplify.Storage.uploadFile(
            local: file[i],
            key: "backups/${FirebaseAuth.instance.currentUser!.email}/" + key,
            onProgress: (progress) async {
              queue[i]!.progress =
                  (progress.getFractionCompleted() * 100).round().toString();
              notifyListeners();
              print("XXPROGRESS: ${queue[i]!.progress}");

              queue[i]!.id = i;
                  (progress.getFractionCompleted() * 100).round().toString();
              if ((progress.getFractionCompleted() * 100).round() == 100) {
                completed = i + 1;
                queue[i]!.key =
                    "backups/${FirebaseAuth.instance.currentUser!.email}/" +
                        key;
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
