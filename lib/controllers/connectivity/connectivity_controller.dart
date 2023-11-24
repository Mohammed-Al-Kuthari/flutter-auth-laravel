import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/providers/shaired.dart';

class ConnectivityController extends AsyncNotifier<ConnectivityResult> {
  @override
  FutureOr<ConnectivityResult> build() {
    return _checkConn();
  }

  Future<ConnectivityResult> _checkConn() {
    final connectivityRepository = ref.read(connectivityRepositoryProvider);
    return connectivityRepository.checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(_checkConn);
  }
}
