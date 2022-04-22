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
  List fileCategoryList = AppConstants.documnetCategories;

  changeIsSelected(int index) {
    for (int i = 0; i < fileCategoryList.length; i++) {
      if (i != index) {
        fileCategoryList[i]['isSelected'] = '0';
      } else {
        fileCategoryList[index]['isSelected'] = '1';
      }
      print('isSelect value in unSelect function is ${fileCategoryList[index]['isSelected']}');
    }
    notifyListeners();
  }

  List fileCategory = AppConstants.categories;

  changeNoOfFiles(int length,int index) {
    for (int i = 0; i < fileCategory.length; i++) {
      if (i != index) {
        fileCategory[i]['isSelected'] = '0';
      } else {
        fileCategory[index]['isSelected'] = '1';
      }
      print('isSelect value in unSelect function is ${fileCategory[index]['isSelected']}');
    }
    notifyListeners();
  }
  changeFileSize(int fileSize,int index) {
    for (int i = 0; i < fileCategory.length; i++) {
      if (i != index) {
        fileCategory[i]['isSelected'] = '0';
      } else {
        fileCategory[index]['isSelected'] = '1';
      }
      print('isSelect value in unSelect function is ${fileCategory[index]['isSelected']}');
    }
    notifyListeners();
  }



// if(fileCategoryList[index]['isSelected']=='1'){
//   fileCategoryList[index]['isSelected']='0';
// }
// else{
//   fileCategoryList[index]['isSelected']='1';
// }

// unSelectAll(int index){
//    for(int i=0;i<fileCategoryList.length;i++){
//      if(i!=index){
//        fileCategoryList[index]['isSelected']='0';
//      }
//      print('isSelect value in unSelect function is ${fileCategoryList[index]['isSelected']}');
//      }
//    notifyListeners();
//    }

}
