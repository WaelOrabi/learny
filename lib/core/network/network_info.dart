import 'dart:async';
import 'connectivity_service.dart';


abstract class NetworkInfo{
  Future<bool> get isConnected;
}
class NetworkInfoImpl implements NetworkInfo{
 final ConnectivityService connectivityService;
  NetworkInfoImpl({required this.connectivityService});

  @override
  Future<bool> get isConnected => connectivityService.checkInternetConnectivity();

}
