import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/providers/shaired.dart';

class AuthController extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> singIn(String email, String password) async {
    final authService = ref.read(authServiceProvider);
    state = const AsyncLoading();
    await authService.signIn(email, password);
    state = const AsyncValue.data("done");
  }

  Future<void> checkUser() async {
    state = const AsyncLoading();
    final tokenStorage = ref.read(secureTokenStorageProvider);
    if (await tokenStorage.read() != null) {
      // TODO: implements get user from api
      // return null; // for now
    }

    // return null;
  }
}
