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
import 'package:quick_backup/data/models/download_model.dart';
import 'package:quick_backup/data/models/queue_model.dart';
import 'package:quick_backup/data/services/auth_services.dart';
import 'package:quick_backup/utilities/i_utills.dart';

import '../../utilities/pref_provider.dart';

class OnlineBackUpVm extends BaseVm {
  List _pics = [];
  List<DownloadModel> _images = [];
  List<DownloadModel> _videos = [];
  List<DownloadModel> _audios = [];
  List<DownloadModel> _documents = [];
  List<DownloadModel> _apps = [];
  bool isLoading=true;
  int _usedSpace = 0;
  List<QueueModel> _selectedFiles = <QueueModel>[];

  bool _isAllImagesSelected = false;
  bool _isAllVideosSelected = false;
  bool _isAllAudioSelected = false;
  bool _isAllFilesSelected = false;
  bool _isAllAppsSelected = false;
  bool _isAllPdfSelected = false;
  bool _isAllPptsSelected = false;
  bool _isAllDocSelected = false;
  bool _isAllOtherDocSelected = false;
  bool _isDocSelected = false;

  bool get isAllImagesSelected => _isAllImagesSelected;

  bool get isAllVideosSelected => _isAllVideosSelected;

  set isAllVideosSelected(bool value) {
    _isAllVideosSelected = value;
  }

  bool get isAllAudioSelected => _isAllAudioSelected;

  set isAllAudioSelected(bool value) {
    _isAllAudioSelected = value;
  }

  bool get isAllFilesSelected => _isAllFilesSelected;

  set isAllFilesSelected(bool value) {
    _isAllFilesSelected = value;
  }

  bool get isAllAppsSelected => _isAllAppsSelected;

  set isAllAppsSelected(bool value) {
    _isAllAppsSelected = value;
  }

  bool get isAllPdfSelected => _isAllPdfSelected;

  set isAllPdfSelected(bool value) {
    _isAllPdfSelected = value;
  }

  bool get isAllPptsSelected => _isAllPptsSelected;

  set isAllPptsSelected(bool value) {
    _isAllPptsSelected = value;
  }

  bool get isAllDocSelected => _isAllDocSelected;

  set isAllDocSelected(bool value) {
    _isAllDocSelected = value;
  }

  bool get isAllOtherDocSelected => _isAllOtherDocSelected;

  set isAllOtherDocSelected(bool value) {
    _isAllOtherDocSelected = value;
  }

  bool get isDocSelected => _isDocSelected;

  set isDocSelected(bool value) {
    _isDocSelected = value;
  }

  set isAllImagesSelected(bool value) {
    _isAllImagesSelected = value;
  }

  int get usedSpace => _usedSpace;

  set usedSpace(int value) {
    _usedSpace = value;
  }

  List<DownloadModel> get images => _images;

  set images(List<DownloadModel> value) {
    _images = value;
    notifyListeners();
  }

  List<DownloadModel> get videos => _videos;

  set videos(List<DownloadModel> value) {
    _videos = value;
    notifyListeners();
  }

  List<DownloadModel> get audios => _audios;

  set audios(List<DownloadModel> value) {
    _audios = value;
    notifyListeners();
  }

  List<DownloadModel> get documents => _documents;

  set documents(List<DownloadModel> value) {
    _documents = value;
    notifyListeners();
  }

  List<DownloadModel> get apps => _apps;

  set apps(List<DownloadModel> value) {
    _apps = value;
    notifyListeners();
  }

  List get pics => _pics;

  set pics(List value) {
    _pics = value;
    notifyListeners();
  }

  List<QueueModel> get selectedFiles => _selectedFiles;

  set selectedFiles(List<QueueModel> value) {
    _selectedFiles = value;
    notifyListeners();
  }

  Future<void> listItems(context) async {
    await AuthService.refreshSession();
    isLoading = true;
    try {
      pics.clear();
      audios.clear();
      videos.clear();
      images.clear();
      documents.clear();
      apps.clear();
      usedSpace = 0;
      final ListResult result = await Amplify.Storage.list(
        options: ListOptions(accessLevel: StorageAccessLevel.protected),
      );
      final List<StorageItem> items = result.items;

      for (int i = 0; i < items.length; i++) {
        final GetUrlResult result =
            await Amplify.Storage.getUrl(key: items[i].key, options: GetUrlOptions(accessLevel: StorageAccessLevel.protected));
        if (mime(items[i].key)!.split("/").first == "video") {
          videos.add(DownloadModel(
              url: result.url, key: items[i].key, date: items[i].lastModified.toString(), size: items[i].size.toString(), isSelected: false));
        } else if (mime(items[i].key)!.split("/").first == "image") {
          images.add(DownloadModel(
              url: result.url, key: items[i].key, date: items[i].lastModified.toString(), size: items[i].size.toString(), isSelected: false));
        } else if (mime(items[i].key)!.split("/").first == "audio") {
          audios.add(DownloadModel(
              url: result.url, key: items[i].key, date: items[i].lastModified.toString(), size: items[i].size.toString(), isSelected: false));
        } else if (mime(items[i].key)!.split("/").first == "document") {
          documents.add(DownloadModel(
              url: result.url, key: items[i].key, date: items[i].lastModified.toString(), size: items[i].size.toString(), isSelected: false));
        } else if (mime(items[i].key)!.split("/").first == "application") {
          if (mime(items[i].key)!.split("/").last == "vnd.android.package-archive") {
            apps.add(DownloadModel(
                url: result.url, key: items[i].key, date: items[i].lastModified.toString(), size: items[i].size.toString(), isSelected: false));
          } else {
            documents.add(DownloadModel(
                url: result.url, key: items[i].key, date: items[i].lastModified.toString(), size: items[i].size.toString(), isSelected: false));
          }
        }
        usedSpace += items[i].size!;

        // pics.add({
        //   "url": result.url,
        //   "key": items[i].key,
        //   'date': items[i].lastModified,
        //   'size': items[i].size
        // });

      }
      isLoading =false;
      notifyListeners();
    } on StorageException catch (e) {
      iUtills().showMessage(context: context, title: "Error", text: e.message.toString());
    } catch (e) {
    }
  }

  set removeFromSelectedList(DownloadModel file) {
    this.selectedFiles.removeWhere((element) => element.name == file.key);

    notifyListeners();
  }

  set addToSelectedList(DownloadModel file) {
    this.selectedFiles.add(QueueModel(key: file.key, name: file.key, size: file.size, date: file.date, status: "pending", progress: "pending"));
    notifyListeners();
  }

  void selectAllInList(List<DownloadModel> list) {
    list.forEach((element) {
      element.isSelected = true;
      addToSelectedList = element;
    });
    notifyListeners();
  }

  void unselectAllInList(List<DownloadModel> list) {
    list.forEach((element) {
      element.isSelected = false;
      removeFromSelectedList = element;
    });
    notifyListeners();
  }

  clearAllSelection() {
    selectedFiles.clear();
    _isAllAppsSelected = false;
    _isAllAudioSelected = false;
    _isAllDocSelected = false;
    _isAllImagesSelected = false;
    _isAllVideosSelected = false;
    notifyListeners();
  }
}
