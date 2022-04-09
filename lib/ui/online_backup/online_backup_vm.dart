import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/base/base_vm.dart';

import '../../data/app_model.dart';
import '../../data/queue_model.dart';
import '../dashboard/dashboard_vm.dart';

class OnlineBackUpVm extends BaseVm {
  var queue = GetIt.I.get<AppModel>().queue;
  List _pics = [];

  List get pics => _pics;

  set pics(List value) {
    _pics = value;
  }
  Future<void> listItems() async {
    try {
      pics.clear();
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> items = result.items;

      for (int i = 0; i < items.length; i++) {
        if (items[i].key.contains(
            "backups/${FirebaseAuth.instance.currentUser!.email}/")) {
          final GetUrlResult result =
          await Amplify.Storage.getUrl(key: items[i].key);
          pics.add({
            "url": result.url,
            "key": items[i].key,
            'date': items[i].lastModified,
            'size': items[i].size
          });
          notifyListeners();
        }
      }
    } on StorageException catch (e) {
      print('Error listing items: $e');
    }
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
                GetIt.I.get<AppModel>().progress =
                    (progress.getFractionCompleted() * 100).round().toString();
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
        GetIt.I.get<AppModel>().progress = "";
        completed = i + 1;
        notifyListeners();
        print("File Already Exist");
      }
    }
  }
}