import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:archive/archive_io.dart';
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

class DashBoardVm extends BaseVm {
  List<File> _files = [];
  List _pics = [];
  bool _ziping = false;

  List<File> get files => _files;
  bool _isUploading = false;

  bool get ziping => _ziping;

  set ziping(bool value) {
    _ziping = value;
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

  pickFile({context}) async {
    files.clear();
    var mfile = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (mfile != null && mfile.files.isNotEmpty) {
      files = mfile.paths.map((path) => File(path!)).toList();
      showDialog(
          context: context,
          builder: (BuildContext mcontext) {
            return AlertDialog(content: QuesScreen());
          });
       uploadFile(context, files);
    }
  }

  static Future<File?> createZipFile(BuildContext context, files) async {
    await Future.delayed(Duration(seconds: 1));
    return zipFile(files);
  }

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

    file.forEach((element) {
      String key = element.path.split('/').last;

      GetIt.I.get<AppModel>().queue.add(QueueModel(
          id: 1,
          name: key,
          date: element.lastModified().toString(),
          size: element.lengthSync().toString(),
          status: "pending",
          progress:"pending"));
    });
    for (int i = 0; i < file.length; i++) {

      String key = file[i].path.split('/').last;
      print("Dxdiag: ${key}");

      await Amplify.Storage.uploadFile(
          local: file[i],
          key: "community/" + key,
          onProgress: (progress) {
            GetIt.I.get<AppModel>().queue[i]!.name = key;
            GetIt.I.get<AppModel>().queue[i]!.progress = progress.getFractionCompleted().toString();
            print("Dxdiag: ${GetIt.I.get<AppModel>().queue[i]!.progress}");

            notifyListeners();
          });
      print("Dxdiag: ${key}");


    }


  }

}

Future<File> zipFile(files) async {
  var pathDown = await getTemporaryDirectory();
  int fileName = DateTime.now().millisecondsSinceEpoch;
  String zipPath = pathDown.path + "/" + '$fileName.zip';
  print('path in the device is....$zipPath');
  var encoder = ZipFileEncoder();
  encoder.create(zipPath);
  files.forEach((element) {
    encoder.addFile(File(element.path));
  });
  File zipFile = File(encoder.zipPath);
  return zipFile;
}


