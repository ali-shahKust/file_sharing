import 'dart:io';

import 'package:flutter/material.dart';

// List<File>? globalImages = [];


class AppConstants {

  static const String fileNameInitialText = "scan_and_backup_";
  static const String imagesPath = "assets/images/";
  static const String login_vector = imagesPath+"login_vector.webp";
  static const String home_screen_background = imagesPath+"home_screen_background.webp";
  static const String google_g = imagesPath+"google_g.svg";
  static const String cloud_icon = imagesPath+"cloud_icon.svg";
  static const String quick_backup_icon = imagesPath+"quick_backup_icon.svg";
  static const String restore_icon = imagesPath+"restore_icon.svg";
  static const String person_icon = imagesPath+"person_icon.svg";

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
      'icon': Icons.image,
      'path': '',
      'color': Colors.blue
    },
    {'title': 'Videos', 'icon': Icons.filter, 'path': '', 'color': Colors.red},
    {
      'title': 'Audio',
      'icon': Icons.headphones,
      'path': '',
      'color': Colors.teal
    },
    {
      'title': 'Documents & Others',
      'icon': Icons.file_copy,
      'path': '',
      'color': Colors.pink
    },
    // {'title': 'Apps', 'icon': Icons.android, 'path': '', 'color': Colors.green},
    // {
    //   'title': 'Whatsapp Statuses',
    //   'icon': Icons.message,
    //   'path': '',
    //   'color': Colors.green
    // },
  ];

  static List<String>   fileTypeList = ['app', 'image', 'video', 'text', 'audio'];

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
    'Size (largest first)',
    'Size (Smallest first)',
  ];
}