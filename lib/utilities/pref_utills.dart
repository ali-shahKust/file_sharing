import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/utilities/pref_provider.dart';
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

  // GET AND SET FOR AVATAR
  static Future<void> getUserAvatarFromPrefsToProvider(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user_avatar') != null) {
      String? userAvatar = prefs.getString('user_avatar');
      setUserAvatarToPrefs(userAvatar!, context);
    } else {
      setUserAvatarToPrefs("", context);
    }
  }

  static Future<void> setUserAvatarToPrefs(String userAvatar, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_avatar', userAvatar);
    Provider.of<PreferencesProvider>(context, listen: false).setUserAvatarInProvider(userAvatar);
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

    if (prefs.getString('user_avatar') != null) {
      String? userAvatar = prefs.getString('user_avatar');
      setUserAvatarToPrefs(userAvatar!, context);
    } else {
      setUserAvatarToPrefs("", context);
    }
  }


  static Future<void> setUserDetailsToPrefs(String userName, String userEmail, String userAvatar, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);
    prefs.setString('user_email', userEmail);
    prefs.setString('user_avatar', userAvatar);
    Provider.of<PreferencesProvider>(context, listen: false).setUserNameInProvider(userName);
    Provider.of<PreferencesProvider>(context, listen: false).setUserEmailInProvider(userEmail);
    Provider.of<PreferencesProvider>(context, listen: false).setUserAvatarInProvider(userAvatar);
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
}