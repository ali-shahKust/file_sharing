import 'dart:io';
import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/models/app_model.dart';

import '../../utilities/pref_provider.dart';

class OnlineBackUpVm extends BaseVm {
  var queue = GetIt.I.get<AppModel>().queue;
  List _pics = [];
  List _images = [];
  List _videos = [];
  List _audios = [];
  List _documents = [];
  List _apps = [];
  int _usedSpace = 0;

  int get usedSpace => _usedSpace;

  set usedSpace(int value) {
    _usedSpace = value;
  }

  List get images => _images;

  set images(List value) {
    _images = value;
  }

  List get videos => _videos;

  set videos(List value) {
    _videos = value;
  }

  List get audios => _audios;

  set audios(List value) {
    _audios = value;
  }

  List get documents => _documents;

  set documents(List value) {
    _documents = value;
  }

  List get apps => _apps;

  set apps(List value) {
    _apps = value;
  }

  List get pics => _pics;

  set pics(List value) {
    _pics = value;
  }

  Future<void> listItems(context) async {
    try {
      pics.clear();
      audios.clear();
      videos.clear();
      images.clear();
      documents.clear();
      usedSpace = 0;
      final ListResult result = await Amplify.Storage.list(
        options: ListOptions(accessLevel: StorageAccessLevel.protected),);
      final List<StorageItem> items = result.items;

      for (int i = 0; i < items.length; i++) {
        final GetUrlResult result =
            await Amplify.Storage.getUrl(key: items[i].key, options: GetUrlOptions(accessLevel: StorageAccessLevel.protected));
        print('MY DATA ${items[i].key}');
        if (mime(items[i].key)!.split("/").first == "video") {
          videos.add({
            "url": result.url,
            "key": items[i].key,
            'date': items[i].lastModified,
            'size': items[i].size
          });
        } else if (mime(items[i].key)!.split("/").first == "image") {
          images.add({
            "url": result.url,
            "key": items[i].key,
            'date': items[i].lastModified,
            'size': items[i].size
          });
        } else if (mime(items[i].key)!.split("/").first == "audio") {
          audios.add({
            "url": result.url,
            "key": items[i].key,
            'date': items[i].lastModified,
            'size': items[i].size
          });
        } else if (mime(items[i].key)!.split("/").first == "document") {
          documents.add({
            "url": result.url,
            "key": items[i].key,
            'date': items[i].lastModified,
            'size': items[i].size
          });
        } else {
          apps.add({
            "url": result.url,
            "key": items[i].key,
            'date': items[i].lastModified,
            'size': items[i].size
          });
        }
        usedSpace += items[i].size!;

        // pics.add({
        //   "url": result.url,
        //   "key": items[i].key,
        //   'date': items[i].lastModified,
        //   'size': items[i].size
        // });
        notifyListeners();
      }
    } on StorageException catch (e) {
      print('Error listing items: $e');
    }
  }
  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }
}
