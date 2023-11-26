import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/models/user.dart';
import 'package:learn/providers/shaired.dart';

class UserController extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() {
    getSignedInUser();
    return null;
  }

  Future<void> getSignedInUser() async {
    state = const AsyncLoading();
    final token = await getStoredToken();
    if (token != null) {
      final authService = ref.read(authServiceProvider);
      try {
        final user = await authService.getUser(token);
        state = AsyncData(user);
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    }
  }

  Future<String?> getStoredToken() async {
    final tokenStorage = ref.read(secureTokenStorageProvider);
    final storedToken = await tokenStorage.read();
    if (storedToken != null) {
      return storedToken;
    } else {
      return null;
    }
  }
}
