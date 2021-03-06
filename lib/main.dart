import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_backup/data/models/app_model.dart';
import 'package:quick_backup/data/local_db/database_helper.dart';
import 'package:quick_backup/data/repo/dashboard/dashboard_repo.dart';
import 'package:quick_backup/data/repo/dashboard/dashboard_repo_imp.dart';
import 'package:quick_backup/data/repo/main/main_repo.dart';
import 'package:quick_backup/data/repo/main/main_repo_imp.dart';
import 'package:quick_backup/data/route/route_setting.dart';
import 'package:quick_backup/data/services/auth_services.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/core_vm.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import 'package:quick_backup/views/local_backup/backup_vm.dart';
import 'package:quick_backup/views/main_page/main_vm.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import 'package:quick_backup/views/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/splash/splash_vm.dart';
import 'data/models/app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I.registerSingleton<AppModel>(AppModel());
  GetIt.I.registerSingleton<DashBoardRepo>(DashBoardRepoImp());
  GetIt.I.registerSingleton<CategoryVm>(CategoryVm());
  GetIt.I.registerSingleton<MainRepo>(MainRepoImp());
  GetIt.I.registerSingleton<DatabaseHelper>(DatabaseHelper());
  GetIt.I.registerSingleton<AuthService>(AuthService());
  await GetIt.I.allReady();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CoreVm()),
          ChangeNotifierProvider(create: (_) => SplashVm()),
          ChangeNotifierProvider(create: (_) => MainVm()),
          ChangeNotifierProvider(create: (_) => CategoryVm()),
          ChangeNotifierProvider(create: (_) => AppModel()),
          ChangeNotifierProvider(create: (_) => OnlineBackUpVm()),
          ChangeNotifierProvider(create: (_) => DownloadVm()),
          ChangeNotifierProvider(create: (_) => DashBoardVm()),
          ChangeNotifierProvider(create: (_) => BackUpVm()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: (settings) => generateRoute(settings),
        ));
  }
}
