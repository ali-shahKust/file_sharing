import 'dart:io';

import 'package:flutter/material.dart';

// List<File>? globalImages = [];

class AppConstants {
  static const String fileNameInitialText = "scan_and_backup_";

  String pdfNamePrefix = 'S&B_${DateTime.now().microsecondsSinceEpoch}';
  static const kDefaultPadding = 20.0;

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    // {
    //   'title': 'Downloads',
    //   'icon': Icons.download,
    //   'path': '',
    //   'color': Colors.purple
    // },
    {
      'title': 'Images',
      'icon': 'assets/file_manager_assets/filemanager_home_images.svg',
      'path': '',
      'startColor':Color.fromRGBO(255, 208, 188, 1),
      'endColor':Color.fromRGBO(254, 120, 62, 1),
    },
    {
      'title': 'Videos',
      'icon': 'assets/file_manager_assets/filemanager_home_video.svg',
      'path': '',
      'startColor':Color.fromRGBO(143, 254, 241, 1),
      'endColor':Color.fromRGBO(31, 209, 191, 1),
    },
    {
      'title': 'Audio',
      'icon': 'assets/file_manager_assets/filemanager_home_audio.svg',
      'path': '',
      'startColor':Color.fromRGBO(254, 175, 255, 1),
      'endColor':Color.fromRGBO(251, 98, 254, 1),
    },
    {
      'title': 'Documents',
      'icon': 'assets/file_manager_assets/filemanager_home_document.svg',
      'path': '',
      'startColor':Color.fromRGBO(173, 235, 254, 1),
      'endColor':Color.fromRGBO(19, 181, 222, 1),
    },

    {
      'title': 'Apps',
      'icon': 'assets/file_manager_assets/filemanager_home_app.svg',
      'path': '',
      'startColor':Color.fromRGBO(174, 148, 254, 1),
      'endColor':Color.fromRGBO(55, 36, 255, 1),
    },
  ];

  static List<String> fileTypeList = ['app', 'image', 'video', 'text', 'audio'];

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
    'Size (largest first)',
    'Size (Smallest first)',
  ];
}
