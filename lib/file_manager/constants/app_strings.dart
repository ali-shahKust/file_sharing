import 'package:flutter/material.dart';

class AppStrings {
  static const cameraTabsOptions = ['Documents', 'Image To Text', 'ID Card'];
  static const List<String> navItemCategories = ['Apps', 'Photos', 'Videos', 'Files', 'Audios'];
  static const EditTabsOptions = ['Filter', 'Adjust', 'Highlight'];
  static const  wallpaperCategoryList = ['Cat', 'Baby', 'Nature', 'Space', 'Abstract', 'Minimal'];
  static GlobalKey adjustImageKey = GlobalKey();
  static const bool isLogin = true;
  static const String scanned = "Scanned";
  static const String appTitle = "Scan and Backup";
  static const String addNew = "Add New";
  static const String next = "Next";
  static const String brightness = "Brightness";
  static const String hue = "Hue";
  static const String saturation = "Saturation";
  static const String brush = "Brush";
  static const String eraser = "Eraser";
  static const String undo = "Undo";
  static const String size = "Size";
  static const String color = "Color";
  static const String edit = "Edit";
  static const String adjust = "Adjust";
  static const String highLight = "Highlight";
  static const String preview = "Preview";
  static const String saveFile = "Save file";
  static const String sharedFile = "Shared";
  static const String recentScannedFile = "Recently scanned";
  static const String securedFile = "Secured Documents";
  static const String documents = "Documents";
  static const String backupTitle = "Your Backup";
  static const String backupSubTitle = "All your files and folders saved on our server";
  static const String sharedTitle = "Shared with you";
  static const String sharedSubTitle = "All files share with you and not saved on server yet";
  static const String recentScannedTitle = "Scanned Files";
  static const String recentScannedSubTitle = "Files you recently scanned but not saved on server yet";
  static const String allFilesTitle = "All Files";
  static const String allFilesSubTitle = "All the files you have scanned, secured and received";
  static const String download = "Download";
  static const String save = "Save";
  static const String secure = "Secure";
  static const String share = "Share";
  static const String gmail = "Gmail";
  static const String rename = "Rename";
  static const String delete = "Delete";
  static const String newUserHeaderTitle = 'Scan your documents';
  static const String newUserHeaderSubTitle = 'Scan and download PDF documents without login';
  static const String newUserFooterTitleProfileScreen = 'Login to secure your files';
  static const String newUserFooterTitle = 'Secure your files';
  static const String newUserFooterSubTitleProfileScreen = 'To secure your files on your server,\nContinue with your account';
  static const String newUserFooterSubTitle = 'To secure your files on our server,\nContinue with your account';
  static const String existingUserHeaderTitle = 'Scan and Secure your documents';
  static const String existingUserHeaderSubTitle = 'Scan and secure your PDF documents on our server';
  static const String existingFooterTitle = 'Your Backup';
  static const String existingFooterSubTitle = 'All your files';
  static const String successTitle = 'Your PDF has been successfully generated';

  static const String successOptions = 'Download PDF or Secure your PDf on Our server';
  static const List<String> transferDocumentCategories = ['SharedDocuments', 'ReceivedDocuments'];
  static const List<String> dummyImageList = [
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3',
    'https://picsum.photos/200/300?random=4'
        'https://picsum.photos/200/300?random=5',
    'https://picsum.photos/200/300?random=6',
    'https://picsum.photos/200/300?random=7',
    'https://picsum.photos/200/300?random=8'
  ];

  List<Map<String, String>> splashData = [
    {
      "heading": "Secure your files",
      "subheading": "Upload your important docs on our server to secure them.",
      "image": "assets/illustrations/onboarding_secure.svg"
    },
    {
      "heading": "Download PDF",
      "subheading": "Scan and download your doc PDF without login",
      "image": "assets/illustrations/onboarding_download.svg"
    },
    {
      "heading": "Share your doc",
      "subheading": "Share your doc with your friends directly from our Server",
      "image": "assets/illustrations/onboarding_share.svg"
    },
  ];
}
