import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/login_page/login_vm.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'main_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVm>(builder: (context, vm, _) {
      double height = SizeConfig.screenHeight!;
      double width = SizeConfig.screenWidth!;
      return Scaffold(
          backgroundColor: AppColors.kScaffoldBackgroundColor,
          body: SafeArea(
              child: SizedBox(
            width: getScreenWidth(context),
            height: getScreenHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  height: height * 0.54,
                  color: AppColors.kShadedWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 22),
                    child: SizedBox(
                      width: width,
                      height: height * 0.36,
                      child: Image.asset(
                        AppConstants.login_vector,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 50),
                  child: Column(
                    children: [
                      iUtills().roundedContainer(context,
                          child: InkWell(
                            onTap: vm.isLoading?null:() {
                              vm.loginWithGoogle(context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.071,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Color(0xffE43E2B).withOpacity(0.2),
                                    Color(0xffF0B401).withOpacity(0.2),
                                    Color(0xff2BA24C).withOpacity(0.2),
                                    Color(0xff3C7CED).withOpacity(0.2),
                                  ])),
                                  child: vm.isLoading?Center(child: SpinKitCircle(color: AppColors.kPrimaryColor,),):Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(AppConstants.google_g),
                                      PrimaryText(
                                        "Login with Google",
                                        color: AppColors.kBlackColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: width,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Color(0xffE43E2B),
                                      Color(0xffF0B401),
                                      Color(0xff2BA24C),
                                      Color(0xff3C7CED),
                                    ])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: false,
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                              thickness: 1.2,
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            PrimaryText(
                              "OR",
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffA9A9A9),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 1.2,
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: false,
                        child: iUtills().roundedContainer(context,
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.071,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Color(0xff7266F8).withOpacity(0.2),
                                    Color(0xff5D50E4).withOpacity(0.2),
                                  ])),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                          AppConstants.person_icon),
                                      PrimaryText(
                                        "Login with Guest User",
                                        color: AppColors.kBlackColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: width,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Color(0xff7266F8),
                                      Color(0xff5D50E4),
                                    ])),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )));
    });
  }
}
