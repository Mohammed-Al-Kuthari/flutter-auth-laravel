import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn/controllers/auth/auth_controller.dart';
import 'package:learn/controllers/connectivity/connectivity_controller.dart';
import 'package:learn/infrastructure/credential_storage/secure_token_storage.dart';
import 'package:learn/infrastructure/requester/requester.dart';
import 'package:learn/models/user.dart';
import 'package:learn/services/auth/auth_service.dart';
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

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final secureTokenStorageProvider = Provider<SecureTokenStorage>(
  (ref) => SecureTokenStorage(ref.read(flutterSecureStorageProvider)),
);

final dioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(
    baseUrl: "https://tedllal.vercel.app/api/v1",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
  )),
);

final requesterProvider =
    Provider<Requester>((ref) => Requester(ref.read(dioProvider)));

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(requesterProvider)),
);
final authControllerProvider = AsyncNotifierProvider<AuthController, bool>(
  () => AuthController(),
);

final fetchUserProvider = FutureProvider<User?>((ref) async {
  final tokenStorage = ref.read(secureTokenStorageProvider);
  String? token = await tokenStorage.read();
  if (token != null) {
    final authService = ref.read(authServiceProvider);
    return authService.getUser(token);
  }
  return null;
});
