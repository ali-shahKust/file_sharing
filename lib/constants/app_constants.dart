import 'package:flutter/material.dart';
import 'package:quick_backup/constants/app_colors.dart';

class AppConstants {
  static const String appName = "Quick Backup";
  static const String fileNameInitialText = "scan_and_backup_";
  static const String imagesPath = "assets/images/";
  static const String login_vector = imagesPath + "login_vector.webp";
  static const String home_screen_background = imagesPath + "home_screen_background.webp";
  static const String google_g = imagesPath + "google_g.svg";
  static const String cloud_icon = imagesPath + "cloud_icon.svg";
  static const String quick_backup_icon = imagesPath + "quick_backup_icon.svg";
  static const String restore_icon = imagesPath + "restore_icon.svg";
  static const String drawer_icon = imagesPath + "drawer_icon.svg";
  static const String person_icon = imagesPath + "person_icon.svg";
  static const String images_icon = imagesPath + "images_icon.svg";
  static const String videos_icon = imagesPath + "videos_icon.svg";
  static const String loader_gif = imagesPath + "cloud_progress_animation.gif";
  static const String audio_icon = imagesPath + "audio_icon.svg";
  static const String document_icon = imagesPath + "document_icon.svg";
  static const String apps_icon = imagesPath + "apps_icon.svg";
  static const String send_file = imagesPath + "send_file.svg";
  static const String transfer_background = imagesPath + "transfer_background.webp";
  static const String splash_screen = imagesPath + "splash_screen.webp";
  static const String on_boarding_page_one = imagesPath + "on_boarding_page_one.webp";
  static const String on_boarding_page_two = imagesPath + "on_boarding_page_two.webp";
  static const String on_boarding_page_three = imagesPath + "on_boarding_page_three.webp";
  static const String next_icon = imagesPath + "next_icon.webp";
  static const String username_background = imagesPath + "username_background.webp";
  static const String exit_logo = imagesPath + "exit_logo.webp";
  static String allow_space = "1000000000";
  static const double padding = 20;
  static const double avatarRadius = 45;
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
    {
      'title': 'Images',
      'icon': 'assets/file_manager_assets/filemanager_home_images.svg',
      'fileSize': '0',
      'noOfFiles': '0 files',
      'startColor': AppColors.kImageIconLightColor,
      'endColor': AppColors.kImageIconDarkColor,
    },
    {
      'title': 'Videos',
      'icon': 'assets/file_manager_assets/filemanager_home_video.svg',
      'fileSize': '0',
      'noOfFiles': '0 files',
      'startColor': AppColors.kVideoIconLightColor,
      'endColor': AppColors.kVideoIconDarkColor,
    },
    {
      'title': 'Audio',
      'icon': 'assets/file_manager_assets/filemanager_home_audio.svg',
      'fileSize': '0',
      'noOfFiles': '0 files',
      'startColor': AppColors.kAudioIconLightColor,
      'endColor': AppColors.kAudioIconDarkColor,
    },
    {
      'title': 'Documents',
      'icon': 'assets/file_manager_assets/filemanager_home_document.svg',
      'fileSize': '0',
      'noOfFiles': '0 files',
      'startColor': AppColors.kDocumentsIconLightColor,
      'endColor': AppColors.kDocumentsIconDarkColor,
    },
    {
      'title': 'Apps',
      'icon': 'assets/file_manager_assets/filemanager_home_app.svg',
      'fileSize': '',
      'noOfFiles': '0 files',
      'startColor': AppColors.kAppsIconLightColor,
      'endColor': AppColors.kAppsIconDarkColor,
    },
  ];

  static List<String> docCategories = ['PDF', 'Slide', 'DOC', 'Other'];
  static List<String> docCategoriesListTileIcon = [
    'assets/images/document_pdf_white.svg',
    'assets/images/document_ppt_white.svg',
    'assets/images/document_doc_white.svg',
    'assets/images/document_archive_white.svg'
  ];

  static List documnetCategories = [
    {
      'title': 'PDF',
      'icon': 'assets/images/document_pdf.svg',
      'isSelected': '1',
      'startColor': Color.fromRGBO(143, 254, 241, 1),
      'endColor': Color.fromRGBO(31, 209, 191, 1),
    },
    {
      'title': 'Slides',
      'icon': 'assets/images/document_ppt.svg',
      'isSelected': '0',
      'startColor': Color.fromRGBO(255, 208, 188, 1),
      'endColor': Color.fromRGBO(254, 120, 62, 1),
    },
    {
      'title': 'DOC',
      'icon': 'assets/images/document_doc.svg',
      'isSelected': '0',
      'startColor': Color.fromRGBO(254, 175, 255, 1),
      'endColor': Color.fromRGBO(251, 98, 254, 1),
    },
    {
      'title': 'Others',
      'icon': 'assets/images/document_archive.svg',
      'isSelected': '0',
      'startColor': Color.fromRGBO(173, 235, 254, 1),
      'endColor': Color.fromRGBO(19, 181, 222, 1),
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
