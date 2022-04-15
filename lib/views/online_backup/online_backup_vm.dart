import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/models/app_model.dart';


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

  }
}