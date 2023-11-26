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
    final response = await requester.dio.get(
      '/user',
      options: Options(
        headers: {'Authorization': "Bearer $token"},
      ),
    );
    return User.fromJson(response.data);
  }
}
