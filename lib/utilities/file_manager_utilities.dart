import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/data/models/file_model.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';

class FileManagerUtilities {
  static String waPath = '/storage/emulated/0/WhatsApp/Media/.Statuses';

  /// Convert Byte to KB, MB, .......
  static String formatBytes(bytes, decimals) {
    if (bytes == 0) return '0.0 KB';
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  /// Get mime information of a file
  static String getMime(String path) {
    File file = File(path);
    String mimeType = mime(file.path) ?? '';
    return mimeType;
  }

  /// Return all available Storage path
  static Future<List<Directory>> getStorageList() async {
    // List<Directory> paths = (await getExternalStorageDirectories())!;


    List<Directory> paths = [
      Directory('/storage/emulated/0/Android/data/com.dummyapp.glass_mor/files'),
      // Directory('/storage/562D-A602/Android/data/com.dummyapp.glass_mor/files')
    ];
    paths.forEach((element) {
      print('${element.path}');
    });
    List<Directory> filteredPaths = <Directory>[];
    for (Directory dir in paths) {
      filteredPaths.add(removeDataDirectory(dir.path));
    }
    return filteredPaths;
  }

  static Directory removeDataDirectory(String path) {
    return Directory(path.split('Android')[0]);
  }

  /// Get all Files and Directories in a Directory
  static Future<List<FileSystemEntity>> getFilesInPath(String path) async {
    Directory dir = Directory(path);
    return dir.listSync();
  }

  /// Get all Files on the Device
  static Future<List<FileSystemEntity>> getAllFiles(
      {bool showHidden = false}) async {
    List<Directory> storages = await getStorageList();
    List<FileSystemEntity> files = <FileSystemEntity>[];
    for (Directory dir in storages) {
      List<FileSystemEntity> allFilesInPath = [];
      // This is important to catch storage errors
      try {
        allFilesInPath =
            await getAllFilesInPath(dir.path, showHidden: showHidden);
      } catch (e) {
        allFilesInPath = [];
        print('exception occur');
        print(e);
      }
      files.addAll(allFilesInPath);
    }
    return files;
  }

  static Future<List<FileSystemEntity>> getRecentFiles(
      {bool showHidden = false}) async {
    List<FileSystemEntity> files = await getAllFiles(showHidden: showHidden);
    files.sort((a, b) => File(a.path)
        .lastAccessedSync()
        .compareTo(File(b.path).lastAccessedSync()));
    return files.reversed.toList();
  }

  static Future<List<FileSystemEntity>> searchFiles(String query,
      {bool showHidden = false}) async {
    List<Directory> storage = await getStorageList();
    List<FileSystemEntity> files = <FileSystemEntity>[];
    for (Directory dir in storage) {
      List fs = await getAllFilesInPath(dir.path, showHidden: showHidden);
      for (FileSystemEntity fs in fs) {
        if (basename(fs.path).toLowerCase().contains(query.toLowerCase())) {
          files.add(fs);
        }
      }
    }
    return files;
  }

  /// Get all files
  static Future<List<FileSystemEntity>> getAllFilesInPath(String path,
      {bool showHidden = false}) async {
    List<FileSystemEntity> files = <FileSystemEntity>[];
    Directory d = Directory(path);
    List<FileSystemEntity> l = d.listSync();
    for (FileSystemEntity file in l) {
      // print('file list in getAllFileInPath function...${file.path}');
      if (FileSystemEntity.isFileSync(file.path)) {
        if (!showHidden) {
          if (!basename(file.path).startsWith('.')) {
            files.add(file);
          }
        } else {
          files.add(file);
        }
      } else {
        if (!file.path.contains('/storage/emulated/0/Android')) {
//          print(file.path);
          if (!showHidden) {
            if (!basename(file.path).startsWith('.')) {
              files.addAll(
                  await getAllFilesInPath(file.path, showHidden: showHidden));
            }
          } else {
            files.addAll(
                await getAllFilesInPath(file.path, showHidden: showHidden));
          }
        }
      }
    }
//    print(files);
    return files;
  }

  static String formatTime(String iso) {
    DateTime date = DateTime.parse(iso);
    DateTime now = DateTime.now();
    DateTime yDay = DateTime.now().subtract(Duration(days: 1));
    DateTime dateFormat = DateTime.parse(
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00.000Z');
    DateTime today = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T00:00:00.000Z');
    DateTime yesterday = DateTime.parse(
        '${yDay.year}-${yDay.month.toString().padLeft(2, '0')}-${yDay.day.toString().padLeft(2, '0')}T00:00:00.000Z');

    if (dateFormat == today) {
      return 'Today ${DateFormat('HH:mm').format(DateTime.parse(iso))}';
    } else if (dateFormat == yesterday) {
      return 'Yesterday ${DateFormat('HH:mm').format(DateTime.parse(iso))}';
    } else {
      return '${DateFormat('MMM dd, HH:mm').format(DateTime.parse(iso))}';
    }
  }

  static List<FileSystemEntity> sortList(
      List<FileSystemEntity> list, int sort) {
    switch (sort) {

      /// Sort by name
      case 0:
        list.sort((f1, f2) => basename(f1.path)
            .toLowerCase()
            .compareTo(basename(f2.path).toLowerCase()));
        break;

      case 1:
        list.sort((f1, f2) => basename(f2.path)
            .toLowerCase()
            .compareTo(basename(f1.path).toLowerCase()));
        break;

      /// Sort by date
      case 2:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) =>
            f1.statSync().modified.compareTo(f2.statSync().modified));
        break;

      case 3:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) =>
            f2.statSync().modified.compareTo(f1.statSync().modified));
        break;

      /// sort by size
      case 4:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) =>
            f2.statSync().size.compareTo(f1.statSync().size));
        break;

      case 5:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) =>
            f1.statSync().size.compareTo(f2.statSync().size));
        break;

      default:
        list.sort();
    }

    return list;
  }
  static Widget? getLogoFromExtension(String? type) {
    if (type != null) {
      if (type==AppConstants.docCategories[0]) {
        return SvgPicture.asset("assets/images/document_pdf_white.svg");
      }
      if (type==AppConstants.docCategories[1]) {
        return SvgPicture.asset("assets/images/document_ppt_white.svg");
      }
      if (type==AppConstants.docCategories[2]) {
        return SvgPicture.asset("assets/images/document_doc_white.svg");
      }
      if (type==AppConstants.docCategories[3]) {
        return SvgPicture.asset("assets/images/document_archive_white.svg");
      }
    }
    return Icon(
      Icons.attachment,
      color: AppColors.kWhiteColor,
      size: SizeConfig.defaultSize! * 4,
    );
  }

  static List<FileMangerModel> getDocList(String type,BuildContext context){
    if (type==AppConstants.docCategories[0]) {
      return Provider.of<CategoryVm>(context,listen: false).pdfList;
    }
    if (type==AppConstants.docCategories[1]) {
      return Provider.of<CategoryVm>(context,listen: false).pptList;
    }
    if (type==AppConstants.docCategories[2]) {
      return Provider.of<CategoryVm>(context,listen: false).docList;
    }
    if (type==AppConstants.docCategories[3]) {
      return Provider.of<CategoryVm>(context,listen: false).otherDocList;
    }
    return Provider.of<CategoryVm>(context,listen: false).pdfList;
  }
}
