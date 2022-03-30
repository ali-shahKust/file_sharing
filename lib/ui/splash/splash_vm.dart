import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glass_mor/data/base/base_vm.dart';

class SplashVm extends BaseVm {
  Widget spinkit = const SpinKitDualRing(
    color: Colors.white60,
    size: 230,
    lineWidth: 0.5,
    duration: Duration(seconds: 1),
  );
}