import 'package:glass_mor/data/queue_model.dart';

import 'base/base_vm.dart';

class AppModel extends BaseVm  {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
   List<QueueModel?> _queue=[];

  List<QueueModel?> get queue => _queue;
  String _progress='0.0';


  String get progress => _progress;

  set progress(String value) {
    _progress = value;
    notifyListeners();
  }

  set queue( List<QueueModel?> value) {
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