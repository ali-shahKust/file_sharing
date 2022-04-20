import 'package:quick_backup/data/base/base_vm.dart';

class PreferencesProvider extends BaseVm {
  bool _userAuthStatus = false;
  String _userEmail = "";
  String _userName = "";
  String _userCognito = "";
  bool _isOnBoardingViewed = false;

  get userAuthStatus => _userAuthStatus;

  get userEmail => _userEmail;

  String get userName => _userName;

  get userCognito => _userCognito;

  get isOnBoardingViewed => _isOnBoardingViewed;

  setUserAuthStatusInProvider(bool authStatus) {
    _userAuthStatus = authStatus;
    notifyListeners();
  }

  setUserEmailInProvider(String userEmail) {
    _userEmail = userEmail;
    notifyListeners();
  }

  setUserNameInProvider(String userName) {
    _userName = userName;
    notifyListeners();
  }

  setCognitoIdInProvider(String userAvatar) {
    _userCognito = userAvatar;
    notifyListeners();
  }

  setIsOnBoardingViewedInProvider(bool isOnBoardingViewed) {
    _isOnBoardingViewed = isOnBoardingViewed;
    notifyListeners();
  }
}