import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/utilities/pref_utills.dart';

class SplashVm extends BaseVm {
  Widget spinkit = const SpinKitDualRing(
    color: Colors.white60,
    size: 230,
    lineWidth: 0.5,
    duration: Duration(seconds: 1),
  );

  getPrefValues(context)async {
    PreferenceUtilities.getIsOnBoardingViewedFromPrefsToProvider(context);
    PreferenceUtilities.getUserAuthStatusFromPrefsToProvider(context);
  }
}