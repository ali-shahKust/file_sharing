import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/constants/app_style.dart';
import 'package:quick_backup/data/route/new_route_helper.dart';
import 'package:quick_backup/utilities/custom_theme.dart';
import 'package:quick_backup/views/main_page/main_screen.dart';
import 'package:quick_backup/views/splash/splash_vm.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashVm>(
      builder: (context, vm, _) => Scaffold(
        backgroundColor: CustomTheme.scafBackground,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: AppStyle.gradientDecoration,
          child: Stack(
            children: [
              Center(
                child: Container(
                  // color: Colors.red,
                  child: vm.spinkit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  timer() async {
    Timer(Duration(seconds: 2), () {
      print('I am here');
      Navigator.pushNamed(context, MainScreen.routeName);
      // routeHelper.MyRouteSettings.navigateMePlease(context, 'mainScreen');
    });
  }
}
