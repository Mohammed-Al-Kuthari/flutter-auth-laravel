import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:learn/exceptions/connectivity/connectivity_exception.dart';

class ConnectivityService {
  Future<ConnectivityResult> checkConnectivity() async {
    await Future.delayed(const Duration(seconds: 1));
    final connState = await (Connectivity().checkConnectivity());

    if (connState == ConnectivityResult.none) {
      throw const ConnectivityExption("No Connection");
    }
    return connState;
  }

  Stream<ConnectivityResult> listenConnectivity() {
    return Connectivity().onConnectivityChanged;
  }
}
