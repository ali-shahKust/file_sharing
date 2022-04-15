import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quick_backup/data/models/queue_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';
import '../base/base_vm.dart';

class AppModel extends BaseVm  {



   List<QueueModel?> _queue=[];

  StreamSubscription? subscription;


   List<QueueModel?> get queue => _queue;

  set queue( List<QueueModel?> value) {
    _queue = value;
    notifyListeners();
  }

  void notifyAppListeners() {
    notifyListeners();
  }



  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }
}