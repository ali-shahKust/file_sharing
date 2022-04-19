import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/constants/app_style.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/utilities/custom_theme.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/on_boarding/on_boarding_screen.dart';
import 'package:quick_backup/views/splash/splash_vm.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      SplashVm vm = SplashVm();
      vm.getPrefValues(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<SplashVm>(
      builder: (context, vm, _) => Scaffold(
        backgroundColor: CustomTheme.scafBackground,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.splash_screen),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PrimaryText(
                "Quick Backup & Restore",
                fontSize: SizeConfig.screenHeight! * 0.026,
                color: AppColors.kBlackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.014,
              ),
              PrimaryText(
                "Backup Your Files On Cloud\nAnd Restore It...",
                textAlign: TextAlign.center,
                fontSize: SizeConfig.screenHeight! * 0.020,
                color: Color(0xff959595),
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.194, vertical: 25),
                child: InkWell(
                  onTap: () {},
                  child: iUtills().gradientButton(
                    height: SizeConfig.screenHeight! * 0.064,
                    width: SizeConfig.screenWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        if (Provider.of<PreferencesProvider>(context,
                                listen: false)
                            .isOnBoardingViewed) {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        } else {
                          Navigator.pushNamed(
                              context, OnBoardingScreen.routeName);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text('Start'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
