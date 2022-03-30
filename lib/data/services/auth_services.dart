import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../amplifyconfiguration.dart';

class AuthService {
  // AuthService(){
  //   configureAmplify();
  // }
  static const platform = const MethodChannel('flutter.native/helper');

  final auth = FirebaseAuth.instance;

  Future<String?> signInAnnonynomously() async {
    String? result;

    await auth.signInAnonymously().then((value) async {
      await value.user!.getIdToken().then((value) async {
        await sendTokenToNative(value).then((value) async {
          result = value;
        });
      });
    });
    await Future.delayed(Duration.zero);

    return result;
  }

  static Future<void> configureAmplify() async {
    if (!Amplify.isConfigured) {
      Amplify.addPlugin(AmplifyStorageS3());
      Amplify.addPlugin(AmplifyAuthCognito());
      print("calledxx");

      try {
        await Amplify.configure(amplifyconfig);
      } on AmplifyAlreadyConfiguredException {
        print("Amplify was already configured. Was the app restarted?");
      }
    } else {
      print(
          "Amplify was already configured. So I am not configuring it again!");
    }
  }

  static Future<String?> sendTokenToNative(String token) async {
    String value = '';
    try {
      value =
          await platform.invokeMethod("sendIDToAWSFromNative", {"id": token});
    } catch (e) {
      print('I am exception in sendTokenToNative: $e');
    }

    return value;
  }
}
