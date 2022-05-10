import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
import 'package:quick_backup/views/user_name_setting/user_name_setting_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtilities {
  // GET AND SET FOR AUTH STATUS
  static Future<void> getUserAuthStatusFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('is_authenticated') != null) {
      // return prefs.getBool('is_authenticated');
      bool? authStatus = prefs.getBool('is_authenticated');
      setUserAuthStatusToPrefs(authStatus!, context);
    } else {
      setUserAuthStatusToPrefs(false, context);
    }
  }

  static Future<void> setUserAuthStatusToPrefs(bool authStatus, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_authenticated', authStatus);
    Provider.of<PreferencesProvider>(context, listen: false).setUserAuthStatusInProvider(authStatus);
  }

  // GET AND SET FOR EMAIL
  static Future<void> getUserEmailFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user_email') != null) {
      String? userEmail = prefs.getString('user_email');
      setUserEmailToPrefs(userEmail!, context);
    } else {
      setUserEmailToPrefs("", context);
    }
  }

  static Future<void> setUserEmailToPrefs(String userEmail, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', userEmail);
    Provider.of<PreferencesProvider>(context, listen: false).setUserEmailInProvider(userEmail);
  }

  // GET AND SET FOR NAME
  static Future<void> getUserNameFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user_name') != null) {
      String? userName = prefs.getString('user_name');
      setUserNameToPrefs(userName!, context);
    } else {
      setUserNameToPrefs("", context);
    }
  }

  static Future<void> setUserNameToPrefs(String userName, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);
    Provider.of<PreferencesProvider>(context, listen: false).setUserNameInProvider(userName);
  }

  // GET AND SET FOR User Cognito
  static Future<void> getUserCognitoFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('cognito_id') != null) {
      String? userCognito = prefs.getString('cognito_id');
      setUserCognitoToPrefs(userCognito!, context);
    } else {
      setUserCognitoToPrefs("", context);
    }
  }

  static Future<void> setUserCognitoToPrefs(String cognitoId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cognito_id', cognitoId);
    Provider.of<PreferencesProvider>(context, listen: false).setCognitoIdInProvider(cognitoId);
  }

  //GET AND SET FOR USER DETAILS

  static Future<void> getUserUserDetailsFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user_email') != null) {
      String? userEmail = prefs.getString('user_email');
      setUserEmailToPrefs(userEmail!, context);
    } else {
      setUserEmailToPrefs("", context);
    }

    if (prefs.getString('user_name') != null) {
      String? userName = prefs.getString('user_name');
      setUserNameToPrefs(userName!, context);
    } else {
      setUserNameToPrefs("", context);
    }

    if (prefs.getString('cognito_id') != null) {
      String? userCognito = prefs.getString('cognito_id');
      setUserCognitoToPrefs(userCognito!, context);
    } else {
      setUserCognitoToPrefs("", context);
    }
  }

  static Future<void> setUserDetailsToPrefs(String userName, String cognitoId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);
    prefs.setString('cognito_id', cognitoId);
    Provider.of<PreferencesProvider>(context, listen: false).setUserNameInProvider(userName);
    Provider.of<PreferencesProvider>(context, listen: false).setCognitoIdInProvider(cognitoId);
  }

  // GET AND SET FOR ISONBOARDING VIEWED
  static Future<void> getIsOnBoardingViewedFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('is_onboarding_viewed') != null) {
      bool? isOnboardingViewed = prefs.getBool('is_onboarding_viewed');
      setIsOnBoardingViewedToPrefs(isOnboardingViewed!, context);
    } else {
      setIsOnBoardingViewedToPrefs(false, context);
    }
  }

  static Future<void> setIsOnBoardingViewedToPrefs(bool isOnBoardingViewed, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_onboarding_viewed', isOnBoardingViewed);
    Provider.of<PreferencesProvider>(context, listen: false).setIsOnBoardingViewedInProvider(isOnBoardingViewed);
  }

  static Future<void> clearAllPrefs(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Provider.of<PreferencesProvider>(context, listen: false).resetUsersData();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
