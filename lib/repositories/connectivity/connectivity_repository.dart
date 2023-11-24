import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityRepository {
  Future<ConnectivityResult> checkConnectivity() async {
    await Future.delayed(const Duration(seconds: 2));
    return (Connectivity().checkConnectivity());
  }
}
