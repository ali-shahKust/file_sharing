import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glass_mor/ui/main_page/main_screen.dart';
import 'package:glass_mor/ui/splash/splash_vm.dart';
import 'package:glass_mor/utills/custom_theme.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:provider/provider.dart';

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
          decoration: iUtills.gradientDecoration,
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

  timer()async {
    Timer(Duration(seconds: 2),(){
      Navigator.pushNamed(context, MainScreen.routeName);
    });
  }
}
