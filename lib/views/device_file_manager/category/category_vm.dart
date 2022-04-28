import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/models/device_app_model.dart';
import 'package:quick_backup/data/models/file_model.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryVm extends BaseVm {

  int _videoIndex = 0;
  bool loading = false;
  bool videoLoader = true;
  List<FileSystemEntity> downloads = <FileSystemEntity>[];
  List<FileMangerModel> videoTempList = [];
  List<int> filesLength = [];
  List<String> downloadTabs = <String>[];
  List<FileMangerModel> _imageList = [];
  List<FileMangerModel> videosList = [];
  List<FileMangerModel> audiosList = [];
  List<FileMangerModel> filesList = [];
  List<FileMangerModel> docList = [];
  List<FileMangerModel> pdfList = [];
  List<FileMangerModel> pptList = [];
  List<FileMangerModel> otherDocList = [];

  get imageList => _imageList;

  // List<FileMangerModel> appsList = <FileMangerModel>[];
  List<File> selectedFiles = <File>[];
  List<File> selectedVideoConversionList = <File>[];

  // List<String> imageTabs = <String>[];
  List<FileSystemEntity> audio = <FileSystemEntity>[];
  List<DeviceAppModel> appList = <DeviceAppModel>[];

  // List<String> audioTabs = <String>[];
  // List<FileSystemEntity> currentFiles = [];

  bool showHidden = false;
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

  bool get isDocSelected => _isDocSelected;

  void ChangeDocSelection(String type) {
    if (type == AppConstants.docCategories[0]) {
      if (_isAllPdfSelected == true) {
        this._isAllPdfSelected = false;
      } else if (_isAllPdfSelected == false) {
        this._isAllPdfSelected = true;
      }
      notifyListeners();
    }
    if (type == AppConstants.docCategories[1]) {

      if (_isAllPptsSelected == true) {
        this._isAllPptsSelected = false;
      } else if (_isAllPptsSelected == false) {
        this._isAllPptsSelected = true;
      }
      notifyListeners();
    }
    if (type == AppConstants.docCategories[2]) {
      if (_isDocSelected == true) {
        this._isDocSelected = false;
      } else if (_isDocSelected == false) {
        this._isDocSelected = true;
      }
      notifyListeners();
    }
    if (type == AppConstants.docCategories[3]) {
      if (_isAllOtherDocSelected == true) {
        this._isAllOtherDocSelected = false;
      } else if (_isAllOtherDocSelected == false) {
        this._isAllOtherDocSelected = true;
      }
      notifyListeners();
    }
  }

  bool getDocCurrentSelection(String type) {
    if (type == AppConstants.docCategories[0]) {
      return isAllPdfSelected;
    }
    if (type == AppConstants.docCategories[1]) {

      return isAllPptsSelected;
    }
    if (type == AppConstants.docCategories[2]) {
      return isDocSelected;
    } else if (type == AppConstants.docCategories[3]) {
      return isAllOtherDocSelected;
    } else
      return isAllPdfSelected;
  }

  int sort = 0;
  final isolates = IsolateHandler();

  set addToSelectedList(File file) {
    this.selectedFiles.add(file);
    notifyListeners();
  }

  set videoIndex(int index) {
    _videoIndex = index;
    notifyListeners();
  }

  incrementVideoIndex() {
    _videoIndex++;
    notifyListeners();
  }

  // fetchAllListLength() {
  //   filesLength.add(_imageList.length);
  //   filesLength.add(videosList.length);
  //   filesLength.add(audiosList.length);
  //   filesLength.add(filesList.length);
  //   filesLength.add(appList.length);
  // }

  int get videoIndex => _videoIndex;

  set removeFromSelectedList(File file) {
    this.selectedFiles.removeWhere((element) => element.path == file.path);


    notifyListeners();
  }

  removeSelectedConversionList(File file) {
    this.selectedVideoConversionList.remove(file);
    notifyListeners();
  }

  getDeviceFileManager() {
    getImages();
    getVideos();
    getAudios();
    getTextFile();
    getAllApps();
  }


  getImages() async {
    // String type = fileTypeList[1].toLowerCase();
    double totalSize = 0;
    setLoading(true);
    _imageList.clear();
    String isolateName = "images";
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) {

      files.forEach((file) async {
        // var base64Image;

        String mimeType = mime(file.path) ?? '';
        if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
          totalSize = totalSize + file.lengthSync();
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          _imageList.add(fm);
        }
      });
      setTotalFilesLength(_imageList.length, 0);
      setTotalFilesSizes(FileManagerUtilities.formatBytes(totalSize, 2), 0);
      setLoading(false);
      notifyListeners();

      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  void setTotalFilesLength(int length, int index) {
    List fileCategory = AppConstants.categories;
    fileCategory[index]['noOfFiles'] = '$length Files';
    notifyListeners();
  }

  void setTotalFilesSizes(String size, int index) {
    List fileCategory = AppConstants.categories;
    fileCategory[index]['fileSize'] = '$size';
    notifyListeners();
  }

  Future<List<FileMangerModel>> getVideos() async {
    double totalSize = 0;

    videosList.clear();
    // selectedVideoConversionList.clear();
    String isolateName = 'videosThumbnail';
    isolates.spawn<String>(
      getThumbnailsWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    // var appDocDir = await getApplicationDocumentsDirectory();
    _port.listen((files) {
      files.forEach((file) async {
        String mimeType = mime(file.path) ?? '';
        if (mimeType.split('/')[0] == AppConstants.fileTypeList[2]) {
          totalSize = totalSize + file.lengthSync();
          FileMangerModel fm = FileMangerModel(
            file: file,
            isSelected: false,
          );
          videosList.add(fm);
        }

        // notifyListeners();
      });

      setTotalFilesLength(videosList.length, 1);
      setTotalFilesSizes(FileManagerUtilities.formatBytes(totalSize, 2), 1);
      // (FileManagerUtilities.formatBytes(totalSize, 3)
      notifyListeners();
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
    return videosList;
  }

  getAudios() async {
    // setVideoLoading(true);
    double totalSize = 0;

    audiosList.clear();
    String isolateName = AppConstants.fileTypeList[4];
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) async {
      files.forEach((file) {
        String mimeType = mime(file.path) ?? '';
        if (mimeType.split('/')[0] == AppConstants.fileTypeList[4]) {
          totalSize = totalSize + file.lengthSync();
          // images.add(file);
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          audiosList.add(fm);
        }

        // notifyListeners();
      });
      setTotalFilesSizes(FileManagerUtilities.formatBytes(totalSize, 2), 2);
      setTotalFilesLength(audiosList.length, 2);
      notifyListeners();
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  getTextFile() async {
    double totalSize = 0;
    setLoading(true);
    pdfList.clear();
    pptList.clear();
    docList.clear();
    otherDocList.clear();
    String isolateName = AppConstants.fileTypeList[3];
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) async {
      files.forEach((file) {

        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path) == '.pdf') {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          pdfList.add(fm);
        }
        if (AppConstants.fileTypeList[3] == 'text' && (extension(file.path) == '.docx' || extension(file.path) == '.doc')) {
          totalSize = totalSize + file.lengthSync();
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          docList.add(fm);
        }

        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path) == '.ppt') {
          totalSize = totalSize + file.lengthSync();
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          pptList.add(fm);
          // // audio.add(file);
        } else if (AppConstants.fileTypeList[3] == 'text' && docExtensions.contains(extension(file.path))) {
          totalSize = totalSize + file.lengthSync();
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          otherDocList.add(fm);
        }
        // if (mimeType.split('/')[0] == fileTypeList[3]) {
        //   // images.add(file);
        //
        // }

        // notifyListeners();
      });
      setTotalFilesSizes(FileManagerUtilities.formatBytes(totalSize, 2), 3);
      setTotalFilesLength(pdfList.length + pptList.length + docList.length + otherDocList.length, 3);
      notifyListeners();
      setLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  static getAllFilesWithIsolate(Map<String, dynamic> context) async {
    String isolateName = context['name'];
    List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
    final messenger = HandledIsolate.initialize(context);
    try {
      final SendPort send = IsolateNameServer.lookupPortByName('${isolateName}_2')!;
      send.send(files);
    } catch (e) {
    }

    messenger.send('done');

  }

  static getThumbnailsWithIsolate(Map<String, dynamic> context) async {
    String isolateName = context['name'];
    List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
    final messenger = HandledIsolate.initialize(context);
    try {
      final SendPort send = IsolateNameServer.lookupPortByName('${isolateName}_2')!;
      send.send(files);
    } catch (e) {
    }
    messenger.send('done');
  }

  getAllApps() async {
    double totalSize = 0;
    setLoading(true);
    appList.clear();
    final apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: false,
      includeAppIcons: true,
    );
    apps.forEach((file) {
      DeviceAppModel appModel = DeviceAppModel(apps: file, isSelected: false);
      // totalSize = totalSize +file.apkFilePath.length.toString();
      appList.add(appModel);
    });
    // setTotalFilesSizes(FileManagerUtilities.formatBytes(totalSize, 3), 4);
    setTotalFilesLength(appList.length, 4);
    notifyListeners();
    setLoading(false);
  }

  static List docExtensions = [
    '.txt',
    '.rtf',
    '.xlsx',
    '.xlsm',
    '.xlsb',
    '.zip',
    '.rar',
  ];

  void changeIsSelected(int index, List<FileMangerModel> list) {
    if (list[index].isSelected) {
      list[index].isSelected = false;
    } else {
      list[index].isSelected = true;
    }
    notifyListeners();
  }

  void selectAllInList(List<FileMangerModel> list) {
    list.forEach((element) {
      element.isSelected = true;
      addToSelectedList = element.file;
    });
    notifyListeners();
  }

  void unselectAllInList(List<FileMangerModel> list) {
    list.forEach((element) {
      element.isSelected = false;
      removeFromSelectedList = element.file;

      notifyListeners();
    });
  }

  void selectAllAppInList(List<DeviceAppModel> list) {
    list.forEach((element) {
      element.isSelected = true;
      addToSelectedList = File(element.apps.apkFilePath);
      // if (element.isSelected) {
      //   element.isSelected = false;
      //   // File(provider.appList[index].apps.apkFilePath)
      //   removeFromSelectedList = File(element.apps.apkFilePath);
      // } else {
      //   element.isSelected = true;
      //   addToSelectedList = File(element.apps.apkFilePath);
      // }
    });

    notifyListeners();
  }

  void unSelectAllAppInList(List<DeviceAppModel> list) {
    list.forEach((element) {
      element.isSelected = false;
      removeFromSelectedList = File(element.apps.apkFilePath);
    });

    notifyListeners();
  }

  Future setSort(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sort', value);
    sort = value;
    notifyListeners();
  }

  getSort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int h = prefs.getInt('sort') ?? 0;
    setSort(h);
  }

  void clearAllSelectedLists() {
    selectedFiles.clear();
    unSelectImages();
    unSelectVideos();
    unSelectAudios();
    unSelectFiles();
    unSelectPdf();
    unSelectPpt();
    unSelectDoc();
    unSelectOthers();
    unSelectApps();
  }

  // void unSelectApps() {
  //   for (int i = 0; i < appList.length; i++) {
  //     appList[i].isSelected = false;
  //   }
  // }

  void unSelectImages() {
    for (int i = 0; i < _imageList.length; i++) {
      _imageList[i].isSelected = false;
    }

  }

  void unSelectVideos() {
    for (int i = 0; i < videosList.length; i++) {
      videosList[i].isSelected = false;
    }
  }

  void unSelectFiles() {
    for (int i = 0; i < filesList.length; i++) {
      filesList[i].isSelected = false;
    }
  }

  void unSelectAudios() {
    for (int i = 0; i < audiosList.length; i++) {
      audiosList[i].isSelected = false;
    }
    notifyListeners();
  }

  void unSelectPdf() {
    for (int i = 0; i < pdfList.length; i++) {
      pdfList[i].isSelected = false;
    }
    notifyListeners();
  }

  void unSelectPpt() {
    for (int i = 0; i < pptList.length; i++) {
      pptList[i].isSelected = false;
    }
    notifyListeners();
  }

  void unSelectDoc() {
    for (int i = 0; i < docList.length; i++) {
      docList[i].isSelected = false;
    }
    notifyListeners();
  }

  void unSelectOthers() {
    for (int i = 0; i < otherDocList.length; i++) {
      otherDocList[i].isSelected = false;
    }
    notifyListeners();
  }

  bool getIsSelectedVal(int index, List<FileMangerModel> list) {
    return list[index].isSelected;
  }

// Specific for Device app  "Model Change"..............
  void changeIsSelectedApp(int index, List<DeviceAppModel> list) {
    if (list[index].isSelected) {
      list[index].isSelected = false;
    } else {
      list[index].isSelected = true;
    }
    notifyListeners();
  }

  // bool getIsSelectedAppVal(int index, List<DeviceAppModel> list) {
  //   return list[index].isSelected;
  // }

  // void isSelectedAppVal(bool val, DeviceAppModel obj) {
  //   obj.isSelected = val;
  //   notifyListeners();
  // }

  void unSelectApps() {
    for (int i = 0; i < appList.length; i++) {
      appList[i].isSelected = false;
    }
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setVideoLoading() {
    videoLoader = !videoLoader;
    notifyListeners();
  }

  setHidden(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hidden', value);
    showHidden = value;
    notifyListeners();
  }

  getHidden() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool h = prefs.getBool('hidden') ?? false;
    setHidden(h);
  }

  bool get isAllImagesSelected => _isAllImagesSelected;

  void changeIsAllImagesSelected() {
    if (_isAllImagesSelected == true) {
      this._isAllImagesSelected = false;
    } else if (_isAllImagesSelected == false) {
      this._isAllImagesSelected = true;
    }
  }

  bool get isAllVideosSelected => _isAllVideosSelected;

  void changeIsAllVideosSelected() {
    if (_isAllVideosSelected == true) {
      this._isAllVideosSelected = false;
    } else if (_isAllVideosSelected == false) {
      this._isAllVideosSelected = true;
    }
    notifyListeners();
  }

  bool get isAllAudioSelected => _isAllAudioSelected;

  void changeIsAllAudioSelected() {
    if (_isAllAudioSelected == true) {
      this._isAllAudioSelected = false;
    } else if (_isAllAudioSelected == false) {
      this._isAllAudioSelected = true;
    }
    // _isAllAudioSelected ==true?false:true;
    notifyListeners();
  }

  bool get isAllAppsSelected => _isAllAppsSelected;

  void changeIsAllAppsSelected() {
    if (_isAllAppsSelected == true) {
      this._isAllAppsSelected = false;
    } else if (_isAllAppsSelected == false) {
      this._isAllAppsSelected = true;
    }
    // _isAllAudioSelected ==true?false:true;
    notifyListeners();
  }

  bool get isAllFilesSelected => _isAllFilesSelected;

  void changeIsAllFilesSelected() {
    if (_isAllFilesSelected == true) {
      this._isAllFilesSelected = false;
    } else if (_isAllFilesSelected == false) {
      this._isAllFilesSelected = true;
    }
    notifyListeners();
  }

  // bool get isAllAppsSelected => _isAllAppsSelected;
  //
  // void changeIsAllAppsSelected() {
  //   if(_isAllAppsSelected ==true){
  //     this._isAllAppsSelected=false;
  //   }
  //   else if(_isAllAppsSelected ==false){
  //     this._isAllAppsSelected=true;
  //   }
  //   notifyListeners();
  // }
  bool get isAllPdfSelected => _isAllPdfSelected;

  void changeIsAllPdfSelected() {
    if (_isAllPdfSelected == true) {
      this._isAllPdfSelected = false;
    } else if (_isAllPdfSelected == false) {
      this._isAllPdfSelected = true;
    }
    notifyListeners();
  }

  bool get isAllPptsSelected => _isAllPptsSelected;

  void changeIsAllPptsSelected() {
    if (_isAllPptsSelected == true) {
      this._isAllPptsSelected = false;
    } else if (_isAllPptsSelected == false) {
      this._isAllPptsSelected = true;
    }
    notifyListeners();
  }

  bool get isAllDocSelected => _isAllDocSelected;

  void changeIsAllDocSelected() {
    if (_isAllDocSelected == true) {
      this._isAllDocSelected = false;
    } else if (_isAllDocSelected == false) {
      this._isAllDocSelected = true;
    }
    notifyListeners();
    // _isAllDocSelected = value;
  }

  bool get isAllOtherDocSelected => _isAllOtherDocSelected;

  void changeIsAllOtherDocSelected(bool value) {
    if (_isAllOtherDocSelected == true) {
      this._isAllOtherDocSelected = false;
    } else if (_isAllOtherDocSelected == false) {
      this._isAllOtherDocSelected = true;
    }
    notifyListeners();
    // _isAllOtherDocSelected = value;
  }

// Future setSort(value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setInt('sort', value);
//   sort = value;
//   notifyListeners();
// }
//
// getSort() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   int h = prefs.getInt('sort') ?? 0;
//   setSort(h);
// }
}
