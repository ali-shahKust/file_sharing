import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/app_model.dart';
import 'package:glass_mor/data/base/base_vm.dart';
import 'package:glass_mor/data/repo/main/main_repo.dart';
import 'package:glass_mor/ui/dashboard/dashboard_screen.dart';

import '../../data/services/auth_services.dart';

class MainVm extends BaseVm {
  final repo = GetIt.instance.get<MainRepo>();

  late String _token;

  String get token => _token;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  set token(String value) {
    _token = value;
  }

  getStarted(context) async {
    isLoading = true;
    await AuthService.configureAmplify().whenComplete(() {
      repo.signInWithGoogle().then((value) async {
        print("AWS Token $value");
        if (value != null) {
          Navigator.pushNamed(context, DashBoardScreen.routeName);
        }
      });
    });
  }
}
