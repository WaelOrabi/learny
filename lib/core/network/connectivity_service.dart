import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  bool hasConnection = false;
  StreamController<bool> connectionChangeController =
  StreamController<bool>.broadcast();
  Stream<bool> get connectionChange => connectionChangeController.stream;

  ConnectivityService() {
    checkInternetConnectivity();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      hasConnection = false;
      return false;
    } else {
      hasConnection = true;
      return true;
    }

  }
}
