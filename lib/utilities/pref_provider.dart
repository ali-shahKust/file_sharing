import 'package:quick_backup/data/base/base_vm.dart';

class PreferencesProvider extends BaseVm {
  bool _userAuthStatus = false;
  String _userEmail = "";
  String _userName = "";
  String _userAvatar = "";
  bool _isOnBoardingViewed = false;

  get userAuthStatus => _userAuthStatus;

  get userEmail => _userEmail;

  get userName => _userName;

  get userAvatar => _userAvatar;

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

  setUserAvatarInProvider(String userAvatar) {
    _userAvatar = userAvatar;
    notifyListeners();
  }

  setIsOnBoardingViewedInProvider(bool isOnBoardingViewed) {
    _isOnBoardingViewed = isOnBoardingViewed;
    notifyListeners();
  }
}