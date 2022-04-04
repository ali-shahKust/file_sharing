import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/views/FileManager/file_manager_home.dart';
import 'package:glass_mor/ui/dashboard/dashboard_screen.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:glass_mor/ui/dashboard/files_list.dart';
import 'package:glass_mor/ui/main_page/main_screen.dart';
import 'package:glass_mor/ui/main_page/main_vm.dart';
import 'package:provider/provider.dart';

import '../../file_manager/provider/FileManagerProvider/category_provider.dart';
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
    case PicturesScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => DashBoardVm(), child: PicturesScreen()));

    case FileManagerHome.routeName:
      return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => CategoryProvider(),
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
