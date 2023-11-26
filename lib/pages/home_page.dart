import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/models/user.dart';
import 'package:learn/pages/login_page.dart';
import 'package:learn/providers/shaired.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchUser = ref.watch(fetchUserProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext build) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.bedtime_outlined),
          )
        ],
      ),
      body: Center(
        child: fetchUser.when(
          data: (User? user) {
            if (user != null) {
              return HomeCenter(user: user);
            } else {
              return const Text('no user');
            }
          },
          error: (err, st) {
            if (err is DioException) {
              return Text("Error: ${err.response!.data}");
            } else {
              return Text(err.toString());
            }
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class HomeCenter extends StatelessWidget {
  final User user;
  const HomeCenter({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Name: ${user.name}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Email: ${user.email}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Phone: +${user.countryCode} ${user.phone}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
