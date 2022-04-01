import 'package:glass_mor/data/queue_model.dart';

import 'base/base_vm.dart';

class AppModel extends BaseVm  {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  late QueueModel _queue;

  QueueModel get queue => _queue;


  set queue(QueueModel value) {
    _queue = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void notifyAppListeners() {
    notifyListeners();
  }

}