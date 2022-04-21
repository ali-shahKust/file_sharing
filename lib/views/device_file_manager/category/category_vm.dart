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
  CategoryVm() {
    print("I am initialize");
  }

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

  List<FileMangerModel> appsList = <FileMangerModel>[];
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
      print(' I am pdf');
      if (_isAllPdfSelected == true) {
        this._isAllPdfSelected = false;
      }
      else if (_isAllPdfSelected == false) {
        this._isAllPdfSelected = true;
      }
      notifyListeners();
    }
    if (type == AppConstants.docCategories[1]) {
      print(' I am ppt ');

      if (_isAllPptsSelected == true) {
        this._isAllPptsSelected = false;
      }
      else if (_isAllPptsSelected == false) {
        this._isAllPptsSelected = true;
      }
      notifyListeners();
    }
    if (type == AppConstants.docCategories[2]) {
      print(' I am doc ');
      if (_isDocSelected == true) {
        this._isDocSelected = false;
      }
      else if (_isDocSelected == false) {
        this._isDocSelected = true;
      }
      notifyListeners();
    }
    if (type == AppConstants.docCategories[3]) {
      print(' I am other ');
      if (_isAllOtherDocSelected == true) {
        this._isAllOtherDocSelected = false;
      }
      else if (_isAllOtherDocSelected == false) {
        this._isAllOtherDocSelected = true;
      }
      notifyListeners();
    }
  }

  bool  getDocCurrentSelection(String type){

    if (type == AppConstants.docCategories[0]) {
      print(' I am pdf');
     return isAllPdfSelected;
    }
    if (type == AppConstants.docCategories[1]) {
      print(' I am ppt ');

     return isAllPptsSelected;
    }
    if (type == AppConstants.docCategories[2]) {
      print(' I am doc ');
     return isDocSelected;
    }
    else if (type == AppConstants.docCategories[3]) {
      print(' I am other ');
     return isAllOtherDocSelected;
    }
    else
      return isAllPdfSelected;


  }


  int sort = 0;
  final isolates = IsolateHandler();

  set addToSelectedList(File file) {
    print('file to add in the list from app screen is $file');
    this.selectedFiles.add(file);
    notifyListeners();
  }

  set videoIndex(int index) {
    _videoIndex = index;
    notifyListeners();
  }

  incrementVideoIndex() {
    _videoIndex++;
    print('Incremented Video Index: ${_videoIndex}');
    notifyListeners();
  }

  fetchAllListLength() {
    filesLength.add(_imageList.length);
    filesLength.add(videosList.length);
    filesLength.add(audiosList.length);
    filesLength.add(filesList.length);
    filesLength.add(appsList.length);
  }

  int get videoIndex => _videoIndex;

  set removeFromSelectedList(File file) {
    print('file to remove from selected list from app screen is $file');
    this.selectedFiles.removeWhere((element) => element.path == file.path);

    // for (int i = 0; i < selectedFiles.length; i++) {
    //   print('data in the selected list after remove is...${selectedFiles[i]}');
    // }
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

  // getAllFilesData() async {
  //   // String type = fileTypeList[1].toLowerCase();
  //   print('get all filedata call....');
  //   setLoading(true);
  //   _imageList.clear();
  //   videosList.clear();
  //   audiosList.clear();
  //   filesList.clear();
  //
  //   String isolateName ='allFiles';
  //   isolates.spawn<String>(
  //     getAllFilesWithIsolate,
  //     name: isolateName,
  //     onReceive: (val) {
  //       print(val);
  //       isolates.kill(isolateName);
  //     },
  //     onInitialized: () => isolates.send('hey', to: isolateName),
  //   );
  //   ReceivePort _port = ReceivePort();
  //   IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_7');
  //   _port.listen((files) {
  //     print('RECEIVED SERVER PORT');
  //
  //     files.forEach((file) async {
  //       // var base64Image;
  //       String mimeType = mime(file.path) ?? '';
  //       if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
  //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
  //         _imageList.add(fm);
  //         print('image list in function is ${_imageList.length}');
  //       }
  //       else if (mimeType.split('/')[0] == AppConstants.fileTypeList[2]) {
  //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
  //         videosList.add(fm);
  //         print('image list in function is ${_imageList.length}');
  //       }
  //       else if (mimeType.split('/')[0] == AppConstants.fileTypeList[3]) {
  //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
  //         audiosList.add(fm);
  //         print('image list in function is ${_imageList.length}');
  //       }
  //      else if (mimeType.split('/')[0] == AppConstants.fileTypeList[4]) {
  //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
  //         filesList.add(fm);
  //         print('image list in function is ${_imageList.length}');
  //       }
  //     });
  //     setLoading(false);
  //     notifyListeners();
  //
  //     _port.close();
  //     IsolateNameServer.removePortNameMapping('${isolateName}_7');
  //   });
  // }

  getImages() async {
    // String type = fileTypeList[1].toLowerCase();
    print('get images fun call...');
    setLoading(true);
    _imageList.clear();
    String isolateName = "images";
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        print(val);
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) {
      print('RECEIVED SERVER PORT');

      files.forEach((file) async {
        print('files in image fun is ${file.path}');
        // var base64Image;
        String mimeType = mime(file.path) ?? '';
        if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
          // final imageBytes = await file.readAsBytes();
          // // print('Here are the image bytes: $imageBytes');
          // String base64ImageLocal = base64Encode(imageBytes);

          // base64Image = base64ImageLocal;
          //imgBytes: base64ImageLocal
          // images.add(file);
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          _imageList.add(fm);
          print('image list in function is ${_imageList.length}');
        }
      });
      setLoading(false);
      notifyListeners();

      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  Future<List<FileMangerModel>> getVideos() async {
    print('get video fun call...');

    // print('type in the function is $type');
    // setVideoLoading(true);
    videosList.clear();
    // selectedVideoConversionList.clear();
    String isolateName = 'videosThumbnail';
    isolates.spawn<String>(
      getThumbnailsWithIsolate,
      name: isolateName,
      onReceive: (val) {
        print(val);
        // setVideoLoading(false);
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    // var appDocDir = await getApplicationDocumentsDirectory();
    _port.listen((files) {
      print('RECEIVED SERVER PORT');
//TODO check async in foreach show issues some time..

      files.forEach((file) async {
        print('files length in provider ${file.length}');
        String mimeType = mime(file.path) ?? '';
        print('mimeType value in the function is $mimeType');
        if (mimeType.split('/')[0] == AppConstants.fileTypeList[2]) {
          FileMangerModel fm = FileMangerModel(
            file: file,
            isSelected: false,
          );
          videosList.add(fm);
        }

        // notifyListeners();
      });
      print('video list length in provider is ${videosList.length}');

      // currentFiles = images;

      // for(int i = 0;i<imageList.length;i++){
      //    print('data in the model is ${imageList[i].fileList[i].path}');
      // }
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
    return videosList;
  }

  getAudios() async {
    // setVideoLoading(true);
    print('get audio fun call...');

    audiosList.clear();
    String isolateName = AppConstants.fileTypeList[4];
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        print(val);
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) async {
      print('RECEIVED SERVER from audio PORT');
      print(files);
      files.forEach((file) {
        String mimeType = mime(file.path) ?? '';
        if (mimeType.split('/')[0] == AppConstants.fileTypeList[4]) {
          // images.add(file);
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          audiosList.add(fm);
        }

        // notifyListeners();
      });

      // setVideoLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  getTextFile() async {
    print('get files fun call...');

    setLoading(true);
    pdfList.clear();
    pptList.clear();
    docList.clear();
    otherDocList.clear();
    print('file type is ${AppConstants.fileTypeList[3]}');
    String isolateName = AppConstants.fileTypeList[3];
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        print(val);
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) async {
      print('RECEIVED SERVER from audio PORT');
      print(files);
      files.forEach((file) {
        // String mimeType = mime(file.path) ?? '';
        //  && docExtensions.contains(extension(file.path))
        // if (AppConstants.fileTypeList[3] == 'text' && docExtensions.contains(extension(file.path))) {
        //   FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
        //   filesList.add(fm);
        //   // audio.add(file);
        // }
        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path) == '.pdf') {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          pdfList.add(fm);
          // audio.add(file);
        }
        if (AppConstants.fileTypeList[3] == 'text' &&
            (extension(file.path) == '.docx' || extension(file.path) == '.doc')) {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          docList.add(fm);
        }

        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path) == '.ppt') {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          pptList.add(fm);
          // // audio.add(file);
        } else if(AppConstants.fileTypeList[3] == 'text' && docExtensions.contains(extension(file.path))) {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          otherDocList.add(fm);
        }
        // if (mimeType.split('/')[0] == fileTypeList[3]) {
        //   // images.add(file);
        //
        // }

        // notifyListeners();
      });

      setLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  static getAllFilesWithIsolate(Map<String, dynamic> context) async {
    print(context);
    String isolateName = context['name'];
    print('Get files');
    List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
    // print('Files $files');
    final messenger = HandledIsolate.initialize(context);
    try {
      final SendPort send = IsolateNameServer.lookupPortByName('${isolateName}_2')!;
      send.send(files);
    } catch (e) {
      print(e);
    }

    messenger.send('done');
    // print(context);
    //
    // String isolateName = context['name'];
    // print('Get files');
    // List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
    // // print('Files $files');
    // final messenger = HandledIsolate.initialize(context);
    // try {
    //   final SendPort send = IsolateNameServer.lookupPortByName('${isolateName}_7')!;
    //   send.send(files);
    // } catch (e) {
    //   print(e);
    // }
    //
    // messenger.send('done');
  }

  static getThumbnailsWithIsolate(Map<String, dynamic> context) async {
    print(context);
    String isolateName = context['name'];
    print('Get files');
    List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
    // print('Files $files');
    final messenger = HandledIsolate.initialize(context);
    try {
      final SendPort send = IsolateNameServer.lookupPortByName('${isolateName}_2')!;
      send.send(files);
    } catch (e) {
      print(e);
    }

    messenger.send('done');
  }

//TODO unCommit to get device apps ....
  getAllApps() async {
    appList.clear();
    final apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: false,
      includeAppIcons: true,
    );
    // print('data in apps object is $apps');
    apps.forEach((file) {
      // String mimeType = mime(file.path) ?? '';
      // if (mimeType.split('/')[0] == fileTypeList[1]) {
      // images.add(file);
      DeviceAppModel appModel = DeviceAppModel(apps: file, isSelected: false);
      appList.add(appModel);

      // for (int i = 0; i < appList.length; i++) {
      //   print('apps in the device is ....${appList[i].apps}');
      // }

      // }
      // notifyListeners();
    });
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
      if (element.isSelected) {
        element.isSelected = false;
        removeFromSelectedList = element.file;
      } else {
        element.isSelected = true;
        addToSelectedList = element.file;
      }
    });

    notifyListeners();
  }
  void selectAllAppInList(List<DeviceAppModel> list) {
    list.forEach((element) {
      if (element.isSelected) {
        element.isSelected = false;
        // File(provider.appList[index].apps.apkFilePath)
        removeFromSelectedList = File(element.apps.apkFilePath);

      } else {
        element.isSelected = true;
        addToSelectedList = File(element.apps.apkFilePath);
      }
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
    unSelectImages();
    unSelectVideos();
    unSelectAudios();
    unSelectFiles();
    unSelectPdf();
    unSelectPpt();
    unSelectDoc();
    unSelectOthers();
  }

  // void unSelectApps() {
  //   for (int i = 0; i < appList.length; i++) {
  //     appList[i].isSelected = false;
  //   }
  // }

  void unSelectImages() {
    for (int i = 0; i < _imageList.length; i++) {
      print('value of isSelected variable is ...${_imageList[i].isSelected}');
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

  void isSelectedVal(bool val, FileMangerModel obj) {
    obj.isSelected = val;
    notifyListeners();
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

  bool getIsSelectedAppVal(int index, List<DeviceAppModel> list) {
    return list[index].isSelected;
  }

  void isSelectedAppVal(bool val, DeviceAppModel obj) {
    obj.isSelected = val;
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

  void  changeIsAllImagesSelected() {
    if(_isAllImagesSelected ==true){
      this._isAllImagesSelected=false;
    }
    else if(_isAllImagesSelected ==false){
      this._isAllImagesSelected=true;
    }
  }
  bool get isAllVideosSelected => _isAllVideosSelected;

  void changeIsAllVideosSelected() {
    if(_isAllVideosSelected ==true){
      this._isAllVideosSelected=false;
    }
    else if(_isAllVideosSelected ==false){
      this._isAllVideosSelected=true;
    }
    notifyListeners();
  }

  bool get isAllAudioSelected => _isAllAudioSelected;

  void changeIsAllAudioSelected() {
    if(_isAllAudioSelected ==true){
      this._isAllAudioSelected=false;
    }
   else if(_isAllAudioSelected ==false){
      this._isAllAudioSelected=true;
    }
    // _isAllAudioSelected ==true?false:true;
    notifyListeners();
  }
  bool get isAllAppsSelected => _isAllAppsSelected;

  void changeIsAllAppsSelected() {
    if(_isAllAppsSelected ==true){
      this._isAllAppsSelected=false;
    }
    else if(_isAllAppsSelected ==false){
      this._isAllAppsSelected=true;
    }
    // _isAllAudioSelected ==true?false:true;
    notifyListeners();
  }

  bool get isAllFilesSelected => _isAllFilesSelected;

  void changeIsAllFilesSelected() {
    if(_isAllFilesSelected ==true){
      this._isAllFilesSelected=false;
    }
    else if(_isAllFilesSelected ==false){
      this._isAllFilesSelected=true;
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
    if(_isAllPdfSelected ==true){
      this._isAllPdfSelected=false;
    }
    else if(_isAllPdfSelected ==false){
      this._isAllPdfSelected=true;
    }
    notifyListeners();

  }

  bool get isAllPptsSelected => _isAllPptsSelected;

  void changeIsAllPptsSelected() {
    if(_isAllPptsSelected ==true){
      this._isAllPptsSelected=false;
    }
    else if(_isAllPptsSelected ==false){
      this._isAllPptsSelected=true;
    }
    notifyListeners();
  }

  bool get isAllDocSelected => _isAllDocSelected;

  void changeIsAllDocSelected() {
    if(_isAllDocSelected ==true){
      this._isAllDocSelected=false;
    }
    else if(_isAllDocSelected ==false){
      this._isAllDocSelected=true;
    }
    notifyListeners();
    // _isAllDocSelected = value;
  }

  bool get isAllOtherDocSelected => _isAllOtherDocSelected;

  void changeIsAllOtherDocSelected(bool value) {
    if(_isAllOtherDocSelected ==true){
      this._isAllOtherDocSelected=false;
    }
    else if(_isAllOtherDocSelected ==false){
      this._isAllOtherDocSelected=true;
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
