import 'package:dio/dio.dart';
import 'package:learn/infrastructure/requester/requester.dart';
import 'package:learn/models/user.dart';

class AuthService {
  final Requester requester;

  AuthService(this.requester);

  Future<String> signIn(String email, String password) async {
    String path = '/auth/login';
    Map<String, dynamic> body = {'email': email, 'password': password};
    Response response = await requester.post(path, body);
    return response.data['access_token'] as String;
  }

  Future<User> getUser(String token) async {
    String path = '/user';
    requester.dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await requester.dio.post(path);
    return User.fromJson(response.data);
  }
}
