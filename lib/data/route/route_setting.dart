import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quick_backup/custom_widgets/queues_screen.dart';
import 'package:quick_backup/views/device_file_manager/category/audio_view.dart';
import 'package:quick_backup/views/device_file_manager/category/images_view.dart';
import 'package:quick_backup/views/device_file_manager/category/videos_view.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_view.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/local_backup/backup_files.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/on_boarding/on_boarding_screen.dart';
import 'package:quick_backup/views/online_backup/cloud_docs_screen.dart';
import 'package:quick_backup/views/online_backup/cloud_images.dart';
import 'package:quick_backup/views/splash/splash.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case DashBoardScreen.routeName:
      return MaterialPageRoute(builder: (context) => DashBoardScreen());
    case BackupFilesScreen.routeName:
      return MaterialPageRoute(builder: (context) => BackupFilesScreen());
    case QuesScreen.routeName:
      return MaterialPageRoute(builder: (context) => QuesScreen(files: settings.arguments as List<File>));
    case DownloadScreen.routeName:
      return MaterialPageRoute(builder: (context) => DownloadScreen(files: settings.arguments as List));
    case CloudDocsScreen.routeName:
      return MaterialPageRoute(builder: (context) => CloudDocsScreen());
    case FileManagerHome.routeName:
      return MaterialPageRoute(builder: (context) => FileManagerHome());
    // case FileManagerHome.routeName:
    // return MaterialPageRoute(builder: (context) => FileManagerHome());
    case ImagesView.routeName:
      return MaterialPageRoute(builder: (context) => ImagesView());
    case VideosView.routeName:
      return MaterialPageRoute(builder: (context) => VideosView());
    case AudioViews.routeName:
      return MaterialPageRoute(builder: (context) => AudioViews());
      case CloudImages.routeName:
      return MaterialPageRoute(builder: (context) => CloudImages());
      case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (context) => OnBoardingScreen());
    case DocumentViews.routeName:
      return MaterialPageRoute(builder: (context) => DocumentViews());
    //   case FileManagerHome.routeName:
    //   return MaterialPageRoute(
    //       builder: (context) => MultiProvider(
    //           providers: [
    //             ChangeNotifierProvider(create: (_) => CoreVm()),
    //             ChangeNotifierProvider(create: (_) => CategoryVm()),
    //             ChangeNotifierProvider(create: (_) => AppModel()),
    //           ],
    //           child: FileManagerHome()));

    default:
      return errorRoute();
  }
}

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Arggg!'),
        ),
        body: const Center(
          child: Text('Oh No! You should not be here! '),
        ),
      );
    },
  );
}
