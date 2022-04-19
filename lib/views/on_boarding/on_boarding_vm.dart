import 'package:flutter/material.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/utilities/pref_utills.dart';
import 'package:quick_backup/views/login_page/login_screen.dart';
import 'package:quick_backup/views/on_boarding/pages/page_one.dart';
import 'package:quick_backup/views/on_boarding/pages/page_three.dart';
import 'package:quick_backup/views/on_boarding/pages/page_two.dart';

class OnBoardingVm extends BaseVm {
  int _currentPage = 0;
  List pages = [PageOneScreen(), PageTwoScreen(), PageThreeScreen()];

  // final pageController = PageController( keepPage: true,initialPage: 0);

  PageController pageController = PageController(
    initialPage: 0,
  );

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  gotoNextPage(context) {
    if (_currentPage < 2) {
      currentPage++;
      pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    } else if (_currentPage == 2) {
      PreferenceUtilities.setIsOnBoardingViewedToPrefs(true, context);
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    }
  }
}
