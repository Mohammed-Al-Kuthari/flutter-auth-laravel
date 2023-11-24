import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/controllers/connectivity/connectivity_controller.dart';
import 'package:learn/repositories/connectivity/connectivity_repository.dart';

final connectivityRepositoryProvider =
    Provider<ConnectivityRepository>((ref) => ConnectivityRepository());

final connectivityControllerProvider = AutoDisposeAsyncNotifierProvider<
    ConnectivityController, ConnectivityResult>(() => ConnectivityController());
