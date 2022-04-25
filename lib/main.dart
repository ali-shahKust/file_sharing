import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_backup/data/models/app_model.dart';
import 'package:quick_backup/data/local_db/database_helper.dart';
import 'package:quick_backup/data/repo/dashboard/dashboard_repo.dart';
import 'package:quick_backup/data/repo/dashboard/dashboard_repo_imp.dart';
import 'package:quick_backup/data/repo/login/login_repo.dart';
import 'package:quick_backup/data/repo/login/login_repo_imp.dart';
import 'package:quick_backup/data/route/route_setting.dart';
import 'package:quick_backup/data/services/auth_services.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/core_vm.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import 'package:quick_backup/views/local_backup/backup_vm.dart';
import 'package:quick_backup/views/login_page/login_vm.dart';
import 'package:quick_backup/views/on_boarding/on_boarding_vm.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import 'package:quick_backup/views/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/splash/splash_vm.dart';
import 'package:quick_backup/views/user_name_setting/user_name_setting_vm.dart';
import 'data/models/app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I.registerSingleton<AppModel>(AppModel());
  GetIt.I.registerSingleton<DashBoardRepo>(DashBoardRepoImp());
  GetIt.I.registerSingleton<CategoryVm>(CategoryVm());
  GetIt.I.registerSingleton<LoginRepo>(LoginRepoImp());
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
          ChangeNotifierProvider(create: (_) => DocumentVm()),
          ChangeNotifierProvider(create: (_) => SplashVm()),
          ChangeNotifierProvider(create: (_) => LoginVm()),
          ChangeNotifierProvider(create: (_) => CategoryVm()),
          ChangeNotifierProvider(create: (_) => AppModel()),
          ChangeNotifierProvider(create: (_) => OnlineBackUpVm()),
          ChangeNotifierProvider(create: (_) => DownloadVm()),
          ChangeNotifierProvider(create: (_) => DashBoardVm()),
          ChangeNotifierProvider(create: (_) => BackUpVm()),
          ChangeNotifierProvider(create: (_) => OnBoardingVm()),
          ChangeNotifierProvider(create: (_) => PreferencesProvider()),
          ChangeNotifierProvider(create: (_) => UserNameSettingVm()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'AvenirNextLTPro',
          ),
        ));
  }
}
