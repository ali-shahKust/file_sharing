import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/data/base/base_vm.dart';
import 'package:quick_backup/data/repo/login/login_repo.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
import 'package:quick_backup/utilities/pref_utills.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/user_name_setting/user_name_settings_screen.dart';

import '../../data/services/auth_services.dart';

class LoginVm extends BaseVm {
  final repo = GetIt.instance.get<LoginRepo>();

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

  loginWithGoogle(context) async {
    isLoading = true;
    await AuthService.configureAmplify().whenComplete(() {
      repo.signInWithGoogle().then((value) async {
        if (value != null) {
          print("AWS Token $value");

          PreferenceUtilities.setUserCognitoToPrefs(value, context);

          if(Provider.of<PreferencesProvider>(context,listen: false).userName.isEmpty){
            Navigator.pushNamedAndRemoveUntil(
                context, UserNameSettingScreen.routeName, (route) => false);
          }

          else{
            Navigator.pushNamedAndRemoveUntil(
                context, DashBoardScreen.routeName, (route) => false);
          }

        }
        isLoading = false;
      });
    });
  }
}
