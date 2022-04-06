import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:archive/archive_io.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/base/base_vm.dart';
import 'package:glass_mor/ui/dashboard/queues_screen.dart';
import 'package:glass_mor/utills/custom_theme.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:glass_mor/widget/primary_text.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/app_model.dart';
import '../../data/queue_model.dart';
import '../../utills/amplify_utills.dart';

int completed = 0;

class DashBoardVm extends BaseVm {
  List<File> _files = [];
  List _pics = [];
  bool _ziping = false;
  StreamSubscription? subscription;

  List<File> get files => _files;
  bool _isUploading = false;

  bool get ziping => _ziping;

  bool _connectionLost = false;
  var queue = GetIt.I.get<AppModel>().queue;

  set ziping(bool value) {
    _ziping = value;
    notifyListeners();
  }


  bool get connectionLost => _connectionLost;

  set connectionLost(bool value) {
    _connectionLost = value;
    notifyListeners();
  }

  bool get isUploading => _isUploading;


  set isUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  set files(List<File> value) {
    _files = value;
    notifyListeners();
  }

  List get pics => _pics;

  set pics(List value) {
    _pics = value;
  }

  DashBoardVm() {
    checkConnection();
  }

  pickFile({context}) async {
    var mfile = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (mfile != null && mfile.files.isNotEmpty) {
      files.clear();
      files = mfile.paths.map((path) => File(path!)).toList();

      uploadFile(context, files);
      Navigator.pushNamed(context, QuesScreen.routeName);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>QuesScreen(files: files,),fullscreenDialog: true));

    }
  }

  bool shouldShow = false;

  checkConnection() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print("Connection name ${result.name}");

        if(result.name == 'none') {
          connectionLost = true;
        }
        else {
          connectionLost = false;
        }
    });
  }


  // static Future<File?> createZipFile(BuildContext context, files) async {
  //   await Future.delayed(Duration(seconds: 1));
  //   return zipFile(files);
  // }

  Future<void> listItems() async {
    try {
      pics.clear();
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> items = result.items;

      for (int i = 0; i < items.length; i++) {
        if (items[i].key.contains("community")) {
          final GetUrlResult result =
              await Amplify.Storage.getUrl(key: items[i].key);
          pics.add({"url": result.url, "key": items[i].key});
          notifyListeners();
        }
      }
    } on StorageException catch (e) {
      print('Error listing items: $e');
    }
  }

  Future<void> downloadFile(
    String key,
  ) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/$key';
    final file = File(filepath);
    bool fileExists = await file.exists();
    if (!fileExists) {
      try {
        await Amplify.Storage.downloadFile(
            key: key,
            local: file,
            onProgress: (progress) {
              print("Fraction completed: " +
                  progress.getFractionCompleted().toString());
            });
        OpenFile.open(file.path);
      } on StorageException catch (e) {
        print('Error downloading file: $e');
      }
    } else {
      print("File Already Exist");
    }
  }

  uploadFile(context, List<File> file) async {
    queue.clear();
    file.forEach((element) {
      String key = element.path.split('/').last;

      queue.add(QueueModel(
          id: null,
          name: key,
          date: element.lastModified().toString(),
          size: element.lengthSync().toString(),
          status: "pending",
          progress: "pending"));
    });

    for (int i = 0; i < file.length; i++) {
      String key = file[i].path.split('/').last;
      try {
        await Amplify.Storage.uploadFile(
            local: file[i],
            key: "community/" + key,
            onProgress: (progress) {
              queue[i]!.progress =
                  (progress.getFractionCompleted() * 100).round().toString();
              print("PROGRESS: ${queue[i]!.progress}");
              GetIt.I.get<AppModel>().progress =
                  (progress.getFractionCompleted() * 100).round().toString();
              if ((progress.getFractionCompleted() * 100).round() == 100) {
                completed = i + 1;
              }
              notifyListeners();
            });
      } on StorageException catch (e) {
        print(e.message);
      } catch (e) {}
    }
  }
}
