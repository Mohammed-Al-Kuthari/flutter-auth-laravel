import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/controllers/connectivity/connectivity_controller.dart';
import 'package:learn/services/connectivity/connectivity_service.dart';

final connectivityServiceProvider =
    Provider<ConnectivityService>((ref) => ConnectivityService());

final connectivityControllerProvider =
    AsyncNotifierProvider<ConnectivityController, ConnectivityResult>(
        () => ConnectivityController());

final connectivityStreamProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivityRepository = ref.read(connectivityServiceProvider);
  return connectivityRepository.listenConnectivity();
});
