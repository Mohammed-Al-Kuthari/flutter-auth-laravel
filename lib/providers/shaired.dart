import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn/controllers/connectivity/connectivity_controller.dart';
import 'package:learn/infrastructure/credential_storage/secure_token_storage.dart';
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

final flutterSecureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());

final secureTokenStorageProvider = Provider<SecureTokenStorage>((ref) {
  final storage = ref.read(flutterSecureStorageProvider);
  return SecureTokenStorage(storage);
});
