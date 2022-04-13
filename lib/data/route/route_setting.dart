import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/core_provider.dart';
import 'package:glass_mor/file_manager/views/file_manager_views/filemanager_home.dart';
import 'package:glass_mor/ui/dashboard/dashboard_screen.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:glass_mor/ui/download/download_screen.dart';
import 'package:glass_mor/ui/download/download_vm.dart';
import 'package:glass_mor/ui/local_backup/backup_vm.dart';
import 'package:glass_mor/ui/main_page/main_screen.dart';
import 'package:glass_mor/ui/main_page/main_vm.dart';
import 'package:glass_mor/ui/online_backup/files_list.dart';
import 'package:glass_mor/ui/online_backup/online_backup_vm.dart';
import 'package:provider/provider.dart';

import '../../file_manager/provider/FileManagerProvider/category_provider.dart';
import '../../widget/queues_screen.dart';
import '../../ui/local_backup/backup_files.dart';
import '../../ui/splash/splash.dart';
import '../../ui/splash/splash_vm.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SplashVm(), child: SplashScreen()));
    case MainScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => MainVm(), child: MainScreen()));
    case DashBoardScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => DashBoardVm(), child: DashBoardScreen()));
    case BackupFilesScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => BackUpVm(), child: BackupFilesScreen()));
    case QuesScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => DashBoardVm(), child: QuesScreen(files: settings.arguments as  List<File>)));
    case DownloadScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => DownloadVm(), child: DownloadScreen(files: settings.arguments as  List)));
    case PicturesScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => OnlineBackUpVm(), child: PicturesScreen()));
      case FileManagerHome.routeName:
      return MaterialPageRoute(
          builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => CoreProvider()),
                ChangeNotifierProvider(create: (_) => CategoryProvider()),
              ],
              child: FileManagerHome()));

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