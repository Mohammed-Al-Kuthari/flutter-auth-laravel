import 'dart:async';

abstract class TokenStorage {
  FutureOr<String?> read();

  Future<void> save(String token);

  Future<void> clear();
}
