import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/models/app_model.dart';
import 'package:quick_backup/data/models/queue_model.dart';
import 'package:quick_backup/utilities/pref_provider.dart';

import '../../configurations/size_config.dart';
import '../../custom_widgets/app_text_widget.dart';
import '../../utilities/i_utills.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/dashboard_vm.dart';
import '../online_backup/online_backup_vm.dart';

class DownloadVm extends BaseVm {

  DownloadVm(){
    loader();
  }
  var queue = GetIt.I.get<AppModel>().downloadQueue;


  StreamSubscription? subscription;
  bool _isLoading = true;


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _connectionLost = false;

  bool get connectionLost => _connectionLost;

  set connectionLost(bool value) {
    _connectionLost = value;
    notifyListeners();
  }
  loader()async {
    isLoading = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
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
      List<QueueModel> files,context
      ) async {
    queue.clear();
    await Future.delayed(Duration(seconds: 2));
    queue.addAll(files);
    isLoading = false;
    final documentsDir = "/storage/emulated/0";
    for (int i = 0; i < files.length; i++) {
      final filepath = documentsDir +
          "/${AppConstants.appName}/" +
          '/${files[i].key!.replaceAll("${Provider.of<PreferencesProvider>(context,listen: false).userCognito}/", "")}';
      final file = File(filepath);

      print("File path is ${files[i].key}");
      bool fileExists = await file.exists();
      if (!fileExists) {
        try {
          await Amplify.Storage.downloadFile(
              options: DownloadFileOptions(accessLevel: StorageAccessLevel.protected),
              key: files[i].key!,
              local: file,
              onProgress: (progress) {
                queue[i]!.progress =
                    (progress.getFractionCompleted() * 100).round().toString();
                queue[i]!.id = i;
                queue[i]!.path = file.path;
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
        queue[i]!.path = file.path;

        print("PROGRESS: ${queue[i]!.progress}");
        completed = i + 1;
        await Future.delayed(Duration.zero);
        notifyListeners();
        print("File Already Exist");
      }
    }

  }
}