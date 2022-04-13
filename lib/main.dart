import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/models/app_model.dart';
import 'package:glass_mor/data/local_db/database_helper.dart';
import 'package:glass_mor/data/repo/dashboard/dashboard_repo.dart';
import 'package:glass_mor/data/repo/dashboard/dashboard_repo_imp.dart';
import 'package:glass_mor/data/repo/main/main_repo.dart';
import 'package:glass_mor/data/repo/main/main_repo_imp.dart';
import 'package:glass_mor/data/route/route_setting.dart';
import 'package:glass_mor/data/services/auth_services.dart';
import 'package:glass_mor/ui/splash/splash.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

import 'file_manager/provider/FileManagerProvider/category_provider.dart';
import 'file_manager/provider/FileManagerProvider/core_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I.registerSingleton<AppModel>(AppModel());
  GetIt.I.registerSingleton<DashBoardRepo>(DashBoardRepoImp());
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
          // ChangeNotifierProvider(create: (_) => AppProvider()),
          ChangeNotifierProvider(create: (_) => CoreProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => AppModel()),
          // ChangeNotifierProvider(create: (_) => CategoryProvider()),
          // ChangeNotifierProvider(create: (_) => UtilityProvider()),
          // ChangeNotifierProvider(create: (_) => TranferHistoryProvider()),
        ],
        child: Consumer<AppModel>(builder: (context, model, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: (settings) => generateRoute(settings),
          );
        }));
  }
}
