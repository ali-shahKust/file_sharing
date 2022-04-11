// import 'dart:convert';
// import 'dart:io';
// import 'dart:isolate';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:custom_file_manager/constants/app_constants.dart';
// import 'package:custom_file_manager/custom_widgets/file_manager_custom_widgets/video_thumbnail.dart';
// import 'package:custom_file_manager/models/file_model.dart';
// import 'package:custom_file_manager/utilities/file_manager_utilities.dart';
// import 'package:flutter/foundation.dart';
// import 'package:isolate_handler/isolate_handler.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CategoryProvider extends ChangeNotifier {
//   // CategoryProvider() {
//   //   // getHidden();
//   //   // getSort();
//   // }
//
//   bool loading = false;
//   List<FileSystemEntity> downloads = <FileSystemEntity>[];
//   List<String> downloadTabs = <String>[];
//   List<FileMangerModel> imageList = <FileMangerModel>[];
//
//   List<FileMangerModel> videosList = <FileMangerModel>[];
//   List<FileMangerModel> audiosList = <FileMangerModel>[];
//   List<FileMangerModel> filesList = <FileMangerModel>[];
//
//   List<FileMangerModel> appsList = <FileMangerModel>[];
//   // List<DeviceAppModel> appList = <DeviceAppModel>[];
//
//   List<File> selectedFiles = <File>[];
//
//   // List<String> selectedFilesPathList = <String>[];
//
//   // List<File> selectedVideoConversionList = <File>[];
//
//   List<String> imageTabs = <String>[];
//
//   List<FileSystemEntity> audio = <FileSystemEntity>[];
//   List<String> audioTabs = <String>[];
//   List<FileMangerModel> currentFiles = [];
//
//   bool showHidden = false;
//   int sort = 0;
//   final isolates = IsolateHandler();
//
//
//   set addToSelectedList(File file) {
//     print('file to add in the list from app screen is $file');
//     this.selectedFiles.add(file);
//     notifyListeners();
//   }
//
//   // addToConversionList(File file) {
//   //   this.selectedVideoConversionList.add(file);
//   //   notifyListeners();
//   // }
//
//   set removeFromSelectedList(File file) {
//     print('file to remove from selected list from app screen is $file');
//     this.selectedFiles.removeWhere((element) => element.path == file.path);
//
//     // for (int i = 0; i < selectedFiles.length; i++) {
//     //   print('data in the selected list after remove is...${selectedFiles[i]}');
//     // }
//     notifyListeners();
//   }
//
//   // removeSelectedConversionList(File file) {
//   //   this.selectedVideoConversionList.remove(file);
//   //   notifyListeners();
//   // }
//
//   getDeviceFileManager() {
//     getImages();
//     getVideos();
//     getAudios();
//     getTextFile();
//     getAllApps();
//   }
//   //TODO uncommit to get all downloads....
//
//   getDownloads() async {
//     setLoading(true);
//     downloadTabs.clear();
//     downloads.clear();
//     downloadTabs.add('All');
//     List<Directory> storages = await FileManagerUtilities.getStorageList();
//     storages.forEach((dir) {
//       if (Directory(dir.path + 'Download').existsSync()) {
//         List<FileSystemEntity> files = Directory(dir.path + 'Download').listSync();
//         print(files);
//         files.forEach((file) {
//           if (FileSystemEntity.isFileSync(file.path)) {
//             downloads.add(file);
//             downloadTabs.add(file.path.split('/')[file.path.split('/').length - 2]);
//             downloadTabs = downloadTabs.toSet().toList();
//             notifyListeners();
//           }
//         });
//       }
//     });
//     setLoading(false);
//   }
//
//   switchCurrentFiles(List list, String label) async {
//     List<FileMangerModel> l = await compute(getTabImages, [list, label]);
//     currentFiles = l;
//     notifyListeners();
//   }
//
//   static Future<List<FileMangerModel>> getTabImages(List item) async {
//     List items = item[0];
//     String label = item[1];
//     List<FileMangerModel> files = [];
//     print('label for sorting is $label ');
//     items.forEach((file) {
//       if ('${file.file.path.split('/')[file.file.path.split('/').length - 2]}' == label) {
//         files.add(file);
//       }
//     });
//     return files;
//   }
//   getImages() async {
//     // String type = fileTypeList[1].toLowerCase();
//     setLoading(true);
//     imageTabs.clear();
//     imageList.clear();
//     imageTabs.add('All');
//     String isolateName = AppConstants.fileTypeList[1];
//     isolates.spawn<String>(
//       getAllFilesWithIsolate,
//       name: isolateName,
//       onReceive: (val) {
//         print(val);
//         isolates.kill(isolateName);
//       },
//       onInitialized: () => isolates.send('hey', to: isolateName),
//     );
//     ReceivePort _port = ReceivePort();
//     IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
//     _port.listen((files) {
//       print('RECEIVED SERVER PORT');
//
//       files.forEach((file) async{
//         // var base64Image;
//         String mimeType = mime(file.path) ?? '';
//         if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
//           // final imageBytes = await file.readAsBytes();
//           // // print('Here are the image bytes: $imageBytes');
//           // String base64ImageLocal = base64Encode(imageBytes);
//
//           // base64Image = base64ImageLocal;
//           //imgBytes: base64ImageLocal
//           // images.add(file);
//           FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
//           imageList.add(fm);
//           imageTabs
//               .add('${file.path.split('/')[file.path.split('/').length - 2]}');
//           imageTabs = imageTabs.toSet().toList();
//         }
//         notifyListeners();
//       });
//       setLoading(false);
//       _port.close();
//       IsolateNameServer.removePortNameMapping('${isolateName}_2');
//     });
//   }
//
//
//   getVideos() async {
//     // print('type in the function is $type');
//     setLoading(true);
//     videosList.clear();
//     // selectedVideoConversionList.clear();
//     String isolateName = AppConstants.fileTypeList[2];
//     isolates.spawn<String>(
//       getAllFilesWithIsolate,
//       name: isolateName,
//       onReceive: (val) {
//         print(val);
//         isolates.kill(isolateName);
//       },
//       onInitialized: () => isolates.send('hey', to: isolateName),
//     );
//     ReceivePort _port = ReceivePort();
//     IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
//     _port.listen((files) {
//       print('RECEIVED SERVER PORT');
// //TODO check async in foreach show issues some time..
//       files.forEach((file) async {
//         String mimeType = mime(file.path) ?? '';
//         print('mimeType value in the function is $mimeType');
//         if (mimeType.split('/')[0] == AppConstants.fileTypeList[2]) {
//           // images.add(file);
//           final uint8list = await VideoThumbnail.thumbnailData(
//             video: file.path,
//             imageFormat: ImageFormat.JPEG,
//             maxWidth: 200,
//             // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//             quality: 25,
//           );
//           FileMangerModel fm = FileMangerModel(file: file, isSelected: false, thumbNail: uint8list);
//           videosList.add(fm);
//         }
//
//         // notifyListeners();
//       });
//
//       // currentFiles = images;
//       setLoading(false);
//       // for(int i = 0;i<imageList.length;i++){
//       //    print('data in the model is ${imageList[i].fileList[i].path}');
//       // }
//       _port.close();
//       IsolateNameServer.removePortNameMapping('${isolateName}_2');
//     });
//   }
//   //TODO uncomment to get all audio files....
//
//   // getAudios() async {
//   //   setLoading(true);
//   //   audiosList.clear();
//   //   String isolateName = AppConstants.fileTypeList[4];
//   //   isolates.spawn<String>(
//   //     getAllFilesWithIsolate,
//   //     name: isolateName,
//   //     onReceive: (val) {
//   //       print(val);
//   //       isolates.kill(isolateName);
//   //     },
//   //     onInitialized: () => isolates.send('hey', to: isolateName),
//   //   );
//   //   ReceivePort _port = ReceivePort();
//   //   IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
//   //   _port.listen((files) async {
//   //     print('RECEIVED SERVER from audio PORT');
//   //     print(files);
//   //     files.forEach((file) {
//   //       String mimeType = mime(file.path) ?? '';
//   //       if (mimeType.split('/')[0] == AppConstants.fileTypeList[4]) {
//   //         // images.add(file);
//   //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
//   //         audiosList.add(fm);
//   //       }
//   //
//   //       // notifyListeners();
//   //     });
//   //
//   //     setLoading(false);
//   //     _port.close();
//   //     IsolateNameServer.removePortNameMapping('${isolateName}_2');
//   //   });
//   // }
//  //TODO uncomment to get all textFile....
//   // getTextFile() async {
//   //   setLoading(true);
//   //   filesList.clear();
//   //   print('file type is ${AppConstants.fileTypeList[3]}');
//   //   String isolateName = AppConstants.fileTypeList[3];
//   //   isolates.spawn<String>(
//   //     getAllFilesWithIsolate,
//   //     name: isolateName,
//   //     onReceive: (val) {
//   //       print(val);
//   //       isolates.kill(isolateName);
//   //     },
//   //     onInitialized: () => isolates.send('hey', to: isolateName),
//   //   );
//   //   ReceivePort _port = ReceivePort();
//   //   IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
//   //   _port.listen((files) async {
//   //     print('RECEIVED SERVER from audio PORT');
//   //     print(files);
//   //     files.forEach((file) {
//   //       // String mimeType = mime(file.path) ?? '';
//   //       //  && docExtensions.contains(extension(file.path))
//   //       if (AppConstants.fileTypeList[3] == 'text' && docExtensions.contains(extension(file.path))) {
//   //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
//   //         filesList.add(fm);
//   //         // audio.add(file);
//   //       }
//   //       // if (mimeType.split('/')[0] == AppConstants.fileTypeList[3]) {
//   //       //   // images.add(file);
//   //       //
//   //       // }
//   //
//   //       // notifyListeners();
//   //     });
//   //
//   //     setLoading(false);
//   //     _port.close();
//   //     IsolateNameServer.removePortNameMapping('${isolateName}_2');
//   //   });
//   // }
//
//   static getAllFilesWithIsolate(Map<String, dynamic> context) async {
//     print(context);
//     String isolateName = context['name'];
//     print('Get files');
//     List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
//     // print('Files $files');
//     final messenger = HandledIsolate.initialize(context);
//     try {
//       final SendPort send = IsolateNameServer.lookupPortByName('${isolateName}_2')!;
//       send.send(files);
//     } catch (e) {
//       print(e);
//     }
//
//     messenger.send('done');
//   }
//   //TODO uncomment to get all apps....
//
//   // getAllApps() async {
//   //   appList.clear();
//   //   final apps = await DeviceApps.getInstalledApplications(
//   //     onlyAppsWithLaunchIntent: true,
//   //     includeSystemApps: false,
//   //     includeAppIcons: true,
//   //   );
//   //   // print('data in apps object is $apps');
//   //   apps.forEach((file) {
//   //     // String mimeType = mime(file.path) ?? '';
//   //     // if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
//   //     // images.add(file);
//   //     DeviceAppModel appModel = DeviceAppModel(apps: file, isSelected: false);
//   //     appList.add(appModel);
//   //
//   //     // for (int i = 0; i < appList.length; i++) {
//   //     //   print('apps in the device is ....${appList[i].apps}');
//   //     // }
//   //
//   //     // }
//   //     // notifyListeners();
//   //   });
//   //   setLoading(false);
//   // }
//   Future setSort(value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('sort', value);
//     sort = value;
//     notifyListeners();
//   }
//
//   // void getaudios() {
//   //   for (int i = 0; i < audiosList.length; i++) {
//   //     print('data in the audio list is ${audiosList[i].file}');
//   //   }
//   // }
//
//   // switchCurrentFiles(List list, String label) async {
//   //   List<FileSystemEntity> l = await compute(getTabImages, [list, label]);
//   //   currentFiles = l;
//   //   notifyListeners();
//   // }
//
//   // static Future<List<FileSystemEntity>> getTabImages(List item) async {
//   //   List items = item[0];
//   //   String label = item[1];
//   //   List<FileSystemEntity> files = [];
//   //   items.forEach((file) {
//   //     if ('${file.path.split('/')[file.path.split('/').length - 2]}' == label) {
//   //       files.add(file);
//   //     }
//   //   });
//   //   return files;
//   // }
//
//   // static Future<List> separateAudios(Map body) async {
//   //   List files = body['files'];
//   //   String type = body['type'];
//   //   List<FileSystemEntity> audio = [];
//   //   List<String> audioTabs = [];
//   //   for (File file in files) {
//   //     String mimeType = mime(file.path) ?? '';
//   //     print(extension(file.path));
//   //     if (type == 'text' && docExtensions.contains(extension(file.path))) {
//   //       audio.add(file);
//   //     }
//   //     if (mimeType.isNotEmpty) {
//   //       if (mimeType.split('/')[0] == type) {
//   //         audio.add(file);
//   //         audioTabs.add('${file.path.split('/')[file.path.split('/').length - 2]}');
//   //         audioTabs = audioTabs.toSet().toList();
//   //       }
//   //     }
//   //   }
//   //   return [audio, audioTabs];
//   // }
//
//   // static List docExtensions = [
//   //   '.txt',
//   //   '.tex',
//   //   '.rtf',
//   //   '.pdf',
//   //   '.xlsx',
//   //   '.xlsm',
//   //   '.xlsb',
//   //   '.docx',
//   //   '.doc',
//   // ];
//
//   void changeIsSelected(int index, List<FileMangerModel> list) {
//     if (list[index].isSelected) {
//       list[index].isSelected = false;
//     } else {
//       list[index].isSelected = true;
//     }
//     notifyListeners();
//   }
//
//   void clearAllSelectedLists() {
//     // unSelectApps();
//     unSelectImages();
//     // unSelectVideos();
//     // unSelectAudios();
//     // unSelectFiles();
//   }
//
//   // void unSelectApps() {
//   //   for (int i = 0; i < appList.length; i++) {
//   //     appList[i].isSelected = false;
//   //   }
//   // }
//
//   void unSelectImages() {
//     for (int i = 0; i < imageList.length; i++) {
//       print('value of isSelected variable is ...${imageList[i].isSelected}');
//       imageList[i].isSelected = false;
//     }
//   }
//
//   // void unSelectVideos() {
//   //   for (int i = 0; i < videosList.length; i++) {
//   //     videosList[i].isSelected = false;
//   //   }
//   // }
//
//   // void unSelectFiles() {
//   //   for (int i = 0; i < filesList.length; i++) {
//   //     filesList[i].isSelected = false;
//   //   }
//   // }
//
//   // void unSelectAudios() {
//   //   for (int i = 0; i < audiosList.length; i++) {
//   //     audiosList[i].isSelected = false;
//   //   }
//   // }
//   //
//   // void changeConvertIsSelected(int index, List<FileMangerModel> list) {
//   //   print('before adding one at list........');
//   //
//   //   for (int i = 0; i < list.length; i++) {
//   //     list[i].isSelected = false;
//   //     // print('is seclect value of video $i at provide is ${list[i].isSelected}');
//   //   }
//   //   if (list[index].isSelected) {
//   //     list[index].isSelected = false;
//   //   } else {
//   //     list[index].isSelected = true;
//   //     addToConversionList(list[index].file);
//   //   }
//   //   print('after adding one at list........');
//   //
//   //   // for (int i = 0; i < list.length; i++) {
//   //   //   // list[i].isSelected = false;
//   //   //   print('is seclect value of video $i at provide is ${list[i].isSelected}');
//   //   // }
//   //
//   //   notifyListeners();
//   // }
//
//   bool getIsSelectedVal(int index, List<FileMangerModel> list) {
//     return list[index].isSelected;
//   }
//
//   void isSelectedVal(bool val, FileMangerModel obj) {
//     obj.isSelected = val;
//     notifyListeners();
//   }
//
// // Specific for Device app  "Model Change"..............
// //   void changeIsSelectedApp(int index, List<DeviceAppModel> list) {
// //     if (list[index].isSelected) {
// //       list[index].isSelected = false;
// //     } else {
// //       list[index].isSelected = true;
// //     }
// //     notifyListeners();
// //   }
//
//   // bool getIsSelectedAppVal(int index, List<DeviceAppModel> list) {
//   //   return list[index].isSelected;
//   // }
//
//   // void isSelectedAppVal(bool val, DeviceAppModel obj) {
//   //   obj.isSelected = val;
//   //   notifyListeners();
//   // }
//
//   void setLoading(value) {
//     loading = value;
//     notifyListeners();
//   }
//
//   setHidden(value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('hidden', value);
//     showHidden = value;
//     notifyListeners();
//   }
//
//   getHidden() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool h = prefs.getBool('hidden') ?? false;
//     setHidden(h);
//   }
//
// }
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/models/app_model.dart';
import 'package:glass_mor/file_manager/models/file_model.dart';
import 'package:glass_mor/file_manager/utilities/file_manager_utilities.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';

class CategoryProvider extends ChangeNotifier {
  // CategoryProvider() {
  //   // getHidden();
  //   // getSort();
  // }

  int _videoIndex = 0;
  bool loading = false;
  bool videoLoader = true;
  List<FileSystemEntity> downloads = <FileSystemEntity>[];
  List<FileMangerModel> videoTempList = [];
  List<String> downloadTabs = <String>[];
  List<FileMangerModel> imageList = <FileMangerModel>[];
  List<FileMangerModel> videosList = <FileMangerModel>[];
  List<FileMangerModel> audiosList = <FileMangerModel>[];
  List<FileMangerModel> filesList = <FileMangerModel>[];

  // List<FileMangerModel> appsList = <FileMangerModel>[];
  // List<DeviceAppModel> appList = <DeviceAppModel>[];

  List<File> selectedFiles = <File>[];

  // List<String> selectedFilesPathList = <String>[];

  List<File> selectedVideoConversionList = <File>[];

  List<String> imageTabs = <String>[];

  List<FileSystemEntity> audio = <FileSystemEntity>[];
  List<String> audioTabs = <String>[];
  List<FileSystemEntity> currentFiles = [];

  bool showHidden = false;
  int sort = 0;
  final isolates = IsolateHandler();

  // bool isConvertionComplete;
  //
  // set isConvertionCompleteStatus (bool val){
  //   this.isConvertionComplete=val;
  //   notifyListeners();
  // }
  // get VideoConvertionStatus{
  //   return this.isConvertionComplete;
  // }
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

  int get videoIndex => _videoIndex;

  addToConversionList(File file) {
    this.selectedVideoConversionList.add(file);
    notifyListeners();
  }

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
    // getVideos();
    getImages();
    // getAudios();
    // getTextFile();
    // getAllApps();
  }

  // getDownloads() async {
  //   setLoading(true);
  //   downloadTabs.clear();
  //   downloads.clear();
  //   downloadTabs.add('All');
  //   List<Directory> storages = await FileUtils.getStorageList();
  //   storages.forEach((dir) {
  //     if (Directory(dir.path + 'Download').existsSync()) {
  //       List<FileSystemEntity> files = Directory(dir.path + 'Download').listSync();
  //       print(files);
  //       files.forEach((file) {
  //         if (FileSystemEntity.isFileSync(file.path)) {
  //           downloads.add(file);
  //           downloadTabs.add(file.path.split('/')[file.path.split('/').length - 2]);
  //           downloadTabs = downloadTabs.toSet().toList();
  //           notifyListeners();
  //         }
  //       });
  //     }
  //   });
  //   setLoading(false);
  // }

  // getImages() async {
  //   // String type = fileTypeList[1].toLowerCase();
  //   setLoading(true);
  //   imageList.clear();
  //   String isolateName = AppConstants.fileTypeList[1];
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
  //   IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
  //   _port.listen((files) {
  //     print('RECEIVED SERVER PORT');
  //
  //     files.forEach((file) async {
  //       // var base64Image;
  //       String mimeType = mime(file.path) ?? '';
  //       if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
  //         // final imageBytes = await file.readAsBytes();
  //         // // print('Here are the image bytes: $imageBytes');
  //         // String base64ImageLocal = base64Encode(imageBytes);
  //
  //         // base64Image = base64ImageLocal;
  //         //imgBytes: base64ImageLocal
  //         // images.add(file);
  //         FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
  //         imageList.add(fm);
  //       }
  //       notifyListeners();
  //     });
  //     setLoading(false);
  //     _port.close();
  //     IsolateNameServer.removePortNameMapping('${isolateName}_2');
  //   });
  // }
  getImages() async {
    print('I am in getImages function...');
    // String type = fileTypeList[1].toLowerCase();
    setLoading(true);
    imageList.clear();
    // String isolateName = AppConstants.fileTypeList[1];
    List<FileSystemEntity> files = await FileManagerUtilities.getAllFiles(showHidden: false);
    files.forEach((file) async {
      print('File list in image function...${file.path}');
      // var base64Image;
      String mimeType = mime(file.path) ?? '';
      if (mimeType.split('/')[0] == AppConstants.fileTypeList[1]) {
        // final imageBytes = await file.readAsBytes();
        // // print('Here are the image bytes: $imageBytes');
        // String base64ImageLocal = base64Encode(imageBytes);

        // base64Image = base64ImageLocal;
        //imgBytes: base64ImageLocal
        // images.add(file);
        FileMangerModel fm = FileMangerModel(file: File(file.path), isSelected: false);
        imageList.add(fm);
      }
      print('data in image list is ${imageList.length}');
      notifyListeners();
    });
    // isolates.spawn<String>(
    //   getAllFilesWithIsolate,
    //   name: isolateName,
    //   onReceive: (val) {
    //     print(val);
    //     isolates.kill(isolateName);
    //   },
    //   onInitialized: () => isolates.send('hey', to: isolateName),
    // );
    // ReceivePort _port = ReceivePort();
    // IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');

  }

  Future<List<FileMangerModel>> getVideos() async {
    // print('type in the function is $type');
    // setVideoLoading(true);
    videosList.clear();
    selectedVideoConversionList.clear();
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
          // images.add(file);
          // final uint8list = await VideoThumbnail.thumbnailData(
          //   video: file.path,
          //
          //   imageFormat: ImageFormat.JPEG,
          //   maxWidth: 200,
          //   // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          //   quality: 25,
          // );
          // print('thumbnail data is $uint8list');
          FileMangerModel fm = FileMangerModel(
            file: file,
            isSelected: false,
          );
          videosList.add(fm);
        }

        // notifyListeners();
      });

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
    setLoading(true);
    filesList.clear();
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
        if (AppConstants.fileTypeList[3] == 'text' && docExtensions.contains(extension(file.path))) {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          filesList.add(fm);
          // audio.add(file);
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

  // getAllApps() async {
  //   appList.clear();
  //   final apps = await DeviceApps.getInstalledApplications(
  //     onlyAppsWithLaunchIntent: true,
  //     includeSystemApps: false,
  //     includeAppIcons: true,
  //   );
  //   // print('data in apps object is $apps');
  //   apps.forEach((file) {
  //     // String mimeType = mime(file.path) ?? '';
  //     // if (mimeType.split('/')[0] == fileTypeList[1]) {
  //     // images.add(file);
  //     DeviceAppModel appModel = DeviceAppModel(apps: file, isSelected: false);
  //     appList.add(appModel);
  //
  //     // for (int i = 0; i < appList.length; i++) {
  //     //   print('apps in the device is ....${appList[i].apps}');
  //     // }
  //
  //     // }
  //     // notifyListeners();
  //   });
  //   setLoading(false);
  // }

  // void getaudios() {
  //   for (int i = 0; i < audiosList.length; i++) {
  //     print('data in the audio list is ${audiosList[i].file}');
  //   }
  // }

  // switchCurrentFiles(List list, String label) async {
  //   List<FileSystemEntity> l = await compute(getTabImages, [list, label]);
  //   currentFiles = l;
  //   notifyListeners();
  // }

  // static Future<List<FileSystemEntity>> getTabImages(List item) async {
  //   List items = item[0];
  //   String label = item[1];
  //   List<FileSystemEntity> files = [];
  //   items.forEach((file) {
  //     if ('${file.path.split('/')[file.path.split('/').length - 2]}' == label) {
  //       files.add(file);
  //     }
  //   });
  //   return files;
  // }

  // static Future<List> separateAudios(Map body) async {
  //   List files = body['files'];
  //   String type = body['type'];
  //   List<FileSystemEntity> audio = [];
  //   List<String> audioTabs = [];
  //   for (File file in files) {
  //     String mimeType = mime(file.path) ?? '';
  //     print(extension(file.path));
  //     if (type == 'text' && docExtensions.contains(extension(file.path))) {
  //       audio.add(file);
  //     }
  //     if (mimeType.isNotEmpty) {
  //       if (mimeType.split('/')[0] == type) {
  //         audio.add(file);
  //         audioTabs.add('${file.path.split('/')[file.path.split('/').length - 2]}');
  //         audioTabs = audioTabs.toSet().toList();
  //       }
  //     }
  //   }
  //   return [audio, audioTabs];
  // }

  static List docExtensions = [
    '.txt',
    '.tex',
    '.rtf',
    '.pdf',
    '.xlsx',
    '.xlsm',
    '.xlsb',
    '.docx',
    '.doc',
  ];

  void changeIsSelected(int index, List<FileMangerModel> list) {
    if (list[index].isSelected) {
      list[index].isSelected = false;
    } else {
      list[index].isSelected = true;
    }
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
    // unSelectApps();
    unSelectImages();
    unSelectVideos();
    unSelectAudios();
    unSelectFiles();
  }

  // void unSelectApps() {
  //   for (int i = 0; i < appList.length; i++) {
  //     appList[i].isSelected = false;
  //   }
  // }

  void unSelectImages() {
    for (int i = 0; i < imageList.length; i++) {
      print('value of isSelected variable is ...${imageList[i].isSelected}');
      imageList[i].isSelected = false;
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
  }

  void changeConvertIsSelected(int index, List<FileMangerModel> list) {
    print('before adding one at list........');

    for (int i = 0; i < list.length; i++) {
      list[i].isSelected = false;
      // print('is seclect value of video $i at provide is ${list[i].isSelected}');
    }
    if (list[index].isSelected) {
      list[index].isSelected = false;
    } else {
      list[index].isSelected = true;
      addToConversionList(list[index].file);
    }
    print('after adding one at list........');

    // for (int i = 0; i < list.length; i++) {
    //   // list[i].isSelected = false;
    //   print('is seclect value of video $i at provide is ${list[i].isSelected}');
    // }

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
//   void changeIsSelectedApp(int index, List<DeviceAppModel> list) {
//     if (list[index].isSelected) {
//       list[index].isSelected = false;
//     } else {
//       list[index].isSelected = true;
//     }
//     notifyListeners();
//   }

  // bool getIsSelectedAppVal(int index, List<DeviceAppModel> list) {
  //   return list[index].isSelected;
  // }
  //
  // void isSelectedAppVal(bool val, DeviceAppModel obj) {
  //   obj.isSelected = val;
  //   notifyListeners();
  // }

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
