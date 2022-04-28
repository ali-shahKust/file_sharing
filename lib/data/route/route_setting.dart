import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quick_backup/views/dashboard/upload_screen.dart';
import 'package:quick_backup/data/models/queue_model.dart';
import 'package:quick_backup/views/device_file_manager/category/audio_view.dart';
import 'package:quick_backup/views/device_file_manager/category/images_view.dart';
import 'package:quick_backup/views/device_file_manager/category/videos_view.dart';
import 'package:quick_backup/views/device_file_manager/device_apps/app_views.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_view.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/filemanager_home.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/local_backup/backup_files.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/on_boarding/on_boarding_screen.dart';
import 'package:quick_backup/views/online_backup/cloud_items_screen.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_apps.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_audios.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_docs.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_images.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_videos.dart';
import 'package:quick_backup/views/splash/splash.dart';
import 'package:quick_backup/views/user_name_setting/update_username.dart';
import 'package:quick_backup/views/user_name_setting/user_name_settings_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case DashBoardScreen.routeName:
      return MaterialPageRoute(builder: (context) => DashBoardScreen());
    case UploadingScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => UploadingScreen(
                map: settings.arguments as Map,
              ));
    case DownloadScreen.routeName:
      return MaterialPageRoute(
          builder: (context) =>
              DownloadScreen(map: settings.arguments as Map));
    case CloudItemsScreen.routeName:
      return MaterialPageRoute(builder: (context) => CloudItemsScreen());
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
      return MaterialPageRoute(
          builder: (context) => CloudImages(
                title: settings.arguments as String,
              ));
    case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (context) => OnBoardingScreen());
    case DocumentViews.routeName:
      return MaterialPageRoute(builder: (context) => DocumentViews());
    case UserNameSettingScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserNameSettingScreen());
    case UpdateUserNameScreen.routeName:
      return MaterialPageRoute(builder: (context) => UpdateUserNameScreen());
    case AppViews.routeName:
      return MaterialPageRoute(builder: (context) => AppViews());
    case CloudVideos.routeName:
      return MaterialPageRoute(builder: (context) => CloudVideos());
    case CloudApps.routeName:
      return MaterialPageRoute(builder: (context) => CloudApps());
    case CloudDocs.routeName:
      return MaterialPageRoute(builder: (context) => CloudDocs());
    case CloudAudios.routeName:
      return MaterialPageRoute(builder: (context) => CloudAudios());
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
