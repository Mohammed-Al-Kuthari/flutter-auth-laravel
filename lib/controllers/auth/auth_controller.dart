import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/providers/shaired.dart';

class AuthController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() {
    return isSignedIn();
  }

  Future<void> singIn(String email, String password) async {
    final authService = ref.read(authServiceProvider);
    final tokenStorage = ref.read(secureTokenStorageProvider);
    try {
      state = const AsyncLoading();
      String token = await authService.signIn(email, password);
      await tokenStorage.save(token);
      state = const AsyncData(true);
    } on DioException catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<String?> getSignInToken() async {
    final tokenStorage = ref.read(secureTokenStorageProvider);
    final storedToken = await tokenStorage.read();
    if (storedToken != null) {
      return storedToken;
    } else {
      return null;
    }
  }

  Future<bool> isSignedIn() => getSignInToken().then((token) => token != null);
}
