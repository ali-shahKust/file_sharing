import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/models/file_model.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentVm extends BaseVm {
  DocumentVm() {
    print("I am initialize");
  }

  bool loading = false;
  List<FileMangerModel> fileList = [];
  List<FileMangerModel> docList = [];

  List<FileMangerModel> pdfList = [];
  List<FileMangerModel> pptList = [];
  List<FileMangerModel> archiveList = [];




  final isolates = IsolateHandler();



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



  getTextFile() async {
    print('get files fun call...');

    setLoading(true);
    fileList.clear();
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
      print('RECEIVED SERVER from document PORT');
      print('length of file in document function is ${files.length}');
      files.forEach((file) {

        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path)=='.pdf') {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          pdfList.add(fm);
          // audio.add(file);
        }
        if (AppConstants.fileTypeList[3] == 'text' && (extension(file.path)=='.docx' ||extension(file.path)=='.doc') ) {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          docList.add(fm);

        }
        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path)=='.zip' ||extension(file.path)=='.rar') {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          archiveList.add(fm);

        }
        if (AppConstants.fileTypeList[3] == 'text' && extension(file.path)=='.ppt') {
          FileMangerModel fm = FileMangerModel(file: file, isSelected: false);
          pptList.add(fm);
          // // audio.add(file);
        }




      });

      setLoading(false);
      notifyListeners();
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

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }



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







}
