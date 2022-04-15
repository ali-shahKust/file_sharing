import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/models/queue_model.dart';

import '../../data/models/app_model.dart';
import '../dashboard/dashboard_vm.dart';

class DownloadVm extends BaseVm {
  var queue = GetIt.I.get<AppModel>().queue;

  StreamSubscription? subscription;


  bool _connectionLost = false;

  bool get connectionLost => _connectionLost;

  set connectionLost(bool value) {
    _connectionLost = value;
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

  Future<void> downloadFile(
      var files,
      ) async {
    queue.clear();
    for (var data in files) {
      String key =
      data['key'].replaceAll("backups/syed.ali.shah3938@gmail.com/", "");
      String date = data['date'].toString();

      queue.add(QueueModel(
          id: null,
          name: key,
          date: date,
          size: data['size'].toString(),
          status: "pending",
          progress: "pending"));
    }
    final documentsDir = "/storage/emulated/0";
    for (int i = 0; i < files.length; i++) {
      final filepath = documentsDir +
          "/Backupfiles" +
          '/${files[i]['key'].replaceAll("backups/syed.ali.shah3938@gmail.com/", "")}';
      final file = File(filepath);
      bool fileExists = await file.exists();
      if (!fileExists) {
        try {
          await Amplify.Storage.downloadFile(
              key: files[i]['key'],
              local: file,
              onProgress: (progress) {
                queue[i]!.progress =
                    (progress.getFractionCompleted() * 100).round().toString();
                queue[i]!.id = i;
                print("PROGRESS: ${queue[i]!.progress}");
                if ((progress.getFractionCompleted() * 100).round() == 100) {
                  completed = i + 1;
                }
                notifyListeners();
              });
        } on StorageException catch (e) {
          print('Error downloading file: $e');
        } catch (e) {
          print('Error downloading file: $e');
        }
      } else {
        queue[i]!.progress = "Exist already";
        queue[i]!.id = i;
        print("PROGRESS: ${queue[i]!.progress}");
        completed = i + 1;
        await Future.delayed(Duration.zero);
        notifyListeners();
        print("File Already Exist");
      }
    }
  }
}