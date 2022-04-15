import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quick_backup/custom_widgets/queues_screen.dart';
import 'package:quick_backup/data/models/app_model.dart';
import 'package:quick_backup/views/device_file_manager/category/audio_view.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/category/files_view.dart';
import 'package:quick_backup/views/device_file_manager/category/images_view.dart';
import 'package:quick_backup/views/device_file_manager/category/videos_view.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/core_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import 'package:quick_backup/views/local_backup/backup_files.dart';
import 'package:quick_backup/views/local_backup/backup_vm.dart';
import 'package:quick_backup/views/main_page/main_screen.dart';
import 'package:quick_backup/views/main_page/main_vm.dart';
import 'package:quick_backup/views/online_backup/files_list.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import 'package:quick_backup/views/splash/splash.dart';
import 'package:quick_backup/views/splash/splash_vm.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => MainScreen());
    case DashBoardScreen.routeName:
      return MaterialPageRoute(builder: (context) => DashBoardScreen());
    case BackupFilesScreen.routeName:
      return MaterialPageRoute(builder: (context) => BackupFilesScreen());
    case QuesScreen.routeName:
      return MaterialPageRoute(builder: (context) => QuesScreen(files: settings.arguments as List<File>));
    case DownloadScreen.routeName:
      return MaterialPageRoute(builder: (context) => DownloadScreen(files: settings.arguments as List));
    case PicturesScreen.routeName:
      return MaterialPageRoute(builder: (context) => PicturesScreen());
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
    case FileViews.routeName:
      return MaterialPageRoute(builder: (context) => FileViews());
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
