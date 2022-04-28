import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/on_boarding/on_boarding_vm.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = 'on_boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingVm>(
      builder: (context, vm, _) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * 0.80,
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: vm.pages.length,
                    onPageChanged: (index){
                      vm.currentPage = index;
                    },
                    allowImplicitScrolling: true,
                    controller: vm.pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [vm.pages[vm.currentPage]],
                      );
                    }),
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * 0.20,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.137,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22)),
                            gradient: LinearGradient(colors: [
                              Color(0xff5B4EE2),
                              Color(0xff7266F8),
                            ])),
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.screenWidth!*0.050,
                      right: SizeConfig.screenWidth!*0.050,
                      bottom: SizeConfig.screenHeight!*0.060,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              vm.gotoNextPage(context);
                            },
                            child: iUtills().gradientButton(
                                width: SizeConfig.screenWidth! * 0.185,
                                height: SizeConfig.screenHeight! * 0.085,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppConstants.next_icon,
                                      width: SizeConfig.screenWidth!*0.05,
                                      height: SizeConfig.screenHeight!*0.022,
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SmoothPageIndicator(
                            controller: vm.pageController,
                            count: vm.pages.length,
                            effect: ExpandingDotsEffect(
                                dotColor: Color(0xffF7E9FF).withOpacity(0.44),
                                activeDotColor: Color(0xffFFFFFF),
                                dotHeight: SizeConfig.screenHeight! * 0.008,
                                dotWidth: SizeConfig.screenWidth! * 0.034),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
