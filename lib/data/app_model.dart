import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:glass_mor/data/queue_model.dart';

import 'base/base_vm.dart';

class AppModel extends BaseVm  {

  AppModel(){
    checkConnection();
  }
  bool _isLoading = false;
  bool _connectionLost = false;

  bool get isLoading => _isLoading;
   List<QueueModel?> _queue=[];

  List<QueueModel?> get queue => _queue;
  String _progress='0.0';

  bool get connectionLost => _connectionLost;

  set connectionLost(bool value) {
    _connectionLost = value;
    notifyListeners();
  }
  StreamSubscription? subscription;

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
  checkConnection() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print("Connection name ${result.name}");

      if (result.name == 'none') {
        connectionLost = true;
      } else if (result.name == 'wifi') {
        connectionLost = false;
      } else if (result.name == 'mobile') {
        connectionLost = false;
      }
    });
  }


  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }
}