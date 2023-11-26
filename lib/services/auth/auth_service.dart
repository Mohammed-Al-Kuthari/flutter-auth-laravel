import 'package:flutter/foundation.dart';
import 'package:learn/infrastructure/requester/requester.dart';

class AuthService {
  final Requester requester;

  AuthService(this.requester);

  Future<void> signIn(String email, String password) async {
    String path = '/auth/login';
    Map<String, dynamic> body = {'email': email, 'password': password};
    final response = await requester.post(path, body);

    debugPrint(response.toString());
  }

  Future<void> getUser(String token) async {
    String path = '/user';
    requester.dio.options.headers["Authorization"] = "Bearer $token";
    final response = await requester.post(path, {});
    debugPrint(response.toString());
  }
}
