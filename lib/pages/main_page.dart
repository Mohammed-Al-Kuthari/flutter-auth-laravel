import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/pages/home_page.dart';
import 'package:learn/pages/login_page.dart';
import 'package:learn/providers/shaired.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authControllerProvider);
    return authService.when(
      data: (isAuth) => isAuth ? const HomePage() : const LoginPage(),
      error: (e, s) => const LoginPage(),
      loading: () => const LoginPage(),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
