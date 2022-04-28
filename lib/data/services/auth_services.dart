import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../amplifyconfiguration.dart';

class AuthService {
  AuthService() {
    init();
  }

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

  late GoogleSignIn _googleSignIn;
  User? _user;

  init() {
    _googleSignIn = GoogleSignIn();
  }

  Future<String?> signInWithGoogle() async {
    String? result;

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await auth.signInWithCredential(credential).then((value) async {
      _user = auth.currentUser;
      await _user!.getIdToken().then((value) async {
        await sendTokenToNative(value).then((value) async {
          result = value;
        });
      });
    });

    await Future.delayed(Duration.zero);

    return await result!;
  }

  static Future<void> configureAmplify() async {
    if (!Amplify.isConfigured) {
      Amplify.addPlugin(AmplifyStorageS3());
      Amplify.addPlugin(AmplifyAuthCognito());

      try {
        await Amplify.configure(amplifyconfig);
      } on AmplifyAlreadyConfiguredException {
      }
    } else {
    }
  }

  static Future<String?> sendTokenToNative(String token) async {
    String value = '';
    try {
      value = await platform.invokeMethod("sendIDToAWSFromNative", {"id": token});
    } catch (e) {
    }

    return value;
  }

  static Future refreshSession() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final User? user = auth.currentUser;
      if (user != null) {
        var token = await user.getIdToken();
        await sendTokenToNative(token).then((value) => {
            });
      }
    } on Exception catch (e) {
    }
  }
}
