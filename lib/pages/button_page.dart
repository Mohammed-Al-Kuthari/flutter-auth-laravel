import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/exceptions/connectivity/connectivity_exception.dart';
import 'package:learn/providers/shaired.dart';

class ButtonPage extends ConsumerWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityStreamProvider, (previous, next) {
      next.whenOrNull(error: (err, _) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: err is ConnectivityExption
                ? Text(err.getMessage())
                : const Text("Unknown Error"),
          ),
        );
      });
    });

    final connectivityProvicer = ref.watch(connectivityControllerProvider);
    final connectivityStreamProvicer = ref.watch(connectivityStreamProvider);
    ThemeData currentTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: currentTheme.colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: connectivityProvicer.when(
              data: (data) => Column(
                children: <Widget>[
                  const SizedBox(height: 32),
                  Text("Connnect wuth: ${data.toString()}"),
                ],
              ),
              error: (err, _) => Column(
                children: <Widget>[
                  const SizedBox(height: 32),
                  err is ConnectivityExption
                      ? Text(err.getMessage())
                      : const Text("Unknown Error"),
                ],
              ),
              loading: () => const Column(
                children: <Widget>[
                  SizedBox(height: 32),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
          Center(
            child: connectivityStreamProvicer.whenOrNull(
              data: (data) => Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  Text("Connnect wuth: ${data.toString().split('.').last}"),
                ],
              ),
              error: (err, _) => err is ConnectivityExption
                  ? Text(err.getMessage())
                  : const Text("Unknown Error"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(22),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                    child: const Text("Start"),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  LoadingButton(
                    onClick: ref
                        .read(connectivityControllerProvider.notifier)
                        .checkConnectivity,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingButton extends StatefulWidget {
  final AsyncCallback onClick;
  const LoadingButton({super.key, required this.onClick});

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  void pay() async {
    setState(() {
      isLoading = true;
    });

    await widget.onClick();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        minimumSize: const Size.fromHeight(16),
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      onPressed: isLoading ? null : pay,
      child: isLoading
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(),
            )
          : const Text('Refresh'),
    );
  }
}
