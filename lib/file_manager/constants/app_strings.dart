import 'package:flutter/material.dart';

class AppStrings {
  static const cameraTabsOptions = ['Documents', 'Image To Text', 'ID Card'];
  static const List<String> navItemCategories = ['Apps', 'Photos', 'Videos', 'Files', 'Audios'];
  static const EditTabsOptions = ['Filter', 'Adjust', 'Highlight'];
  static const  wallpaperCategoryList = ['Cat', 'Baby', 'Nature', 'Space', 'Abstract', 'Minimal'];
  static GlobalKey adjustImageKey = GlobalKey();
  static const bool isLogin = true;
  static const String scanned = "Scanned";
  static const String appTitle = "BackUp App";
  static const String phoneStorage = "Phone Storage";


  // static const List<String> transferDocumentCategories = ['SharedDocuments', 'ReceivedDocuments'];
  // static const List<String> dummyImageList = [
  //   'https://picsum.photos/200/300?random=1',
  //   'https://picsum.photos/200/300?random=2',
  //   'https://picsum.photos/200/300?random=3',
  //   'https://picsum.photos/200/300?random=4'
  //       'https://picsum.photos/200/300?random=5',
  //   'https://picsum.photos/200/300?random=6',
  //   'https://picsum.photos/200/300?random=7',
  //   'https://picsum.photos/200/300?random=8'
  // ];

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
