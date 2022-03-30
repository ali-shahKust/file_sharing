import 'base/base_vm.dart';

class AppModel extends BaseVm  {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void notifyAppListeners() {
    notifyListeners();
  }

}