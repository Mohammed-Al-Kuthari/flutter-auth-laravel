import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: TextSubmitWidget(),
        ), //
      ),
    );
  }
}

class TextSubmitWidget extends ConsumerStatefulWidget {
  const TextSubmitWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<TextSubmitWidget> createState() => _TextSubmitWidgetState();
}

class _TextSubmitWidgetState extends ConsumerState<TextSubmitWidget> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  String? get _emailErrorText {
    final text = _emailController.value.text;
    if (text.isEmpty) {
      return 'Error: Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Error: Too short';
    }
    return null;
  }

  String? get _passErrorText {
    final text = _passController.value.text;
    if (text.isEmpty) {
      return 'Error: Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Error: Too short';
    }
    return null;
  }

  void _submit() async {
    final form = _formKey.currentState!;
    setState(() {
      _isSubmitted = true;
      _isSubmitting = true;
    });
    if (form.validate()) {
      form.save();

      final formData = {
        'email': _emailController.value.text,
        'password': _passController.value.text,
      };

      await Future.delayed(const Duration(seconds: 2));
      debugPrint(formData.toString());
    }
    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 80,
            child: CustomTextField(
              label: "Enter your email",
              controller: _emailController,
              isSubmitted: _isSubmitted,
              errorText: _emailErrorText,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'validator: Can\'t be empty';
                }
                if (text.length < 4) {
                  return 'validator: Too short';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 80,
            child: CustomTextField(
              label: "Enter your password",
              controller: _passController,
              isSubmitted: _isSubmitted,
              errorText: _passErrorText,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'validator: Can\'t be empty';
                }
                if (text.length < 4) {
                  return 'validator: Too short';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isSubmitted;
  final String? errorText;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isSubmitted,
    required this.errorText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, TextEditingValue value, __) {
        return TextFormField(
          autovalidateMode: isSubmitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            // the errorText getter *depends* on _controller
            errorText: isSubmitted ? errorText : null,
          ),
        );
      },
    );
  }
}
