import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn/infrastructure/credential_storage/token_storage.dart';

class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _storage;

  SecureTokenStorage(this._storage);

  static const _key = 'TedllalApp_Credential';

  String? _cachedToken;

  @override
  FutureOr<String?> read() {
    if (_cachedToken != null) return _cachedToken;

    return _storage.read(key: _key);
  }

  @override
  Future<void> save(String token) {
    _cachedToken = token;
    return _storage.write(key: _key, value: token);
  }

  @override
  Future<void> clear() {
    _cachedToken = null;
    return _storage.delete(key: _key);
  }
}
