import 'package:flutter/material.dart';
import 'package:flutter_journey/features/auth/auth_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authController = context.read<AuthController>();
    _emailController.text = authController.demoEmail;
    _passwordController.text = authController.demoPassword;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final authController = context.read<AuthController>();
    final success = await authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      context.go('/');
      return;
    }

    messenger.showSnackBar(
      SnackBar(content: Text(authController.errorMessage ?? 'ログインに失敗しました')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ログイン',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'メールアドレス',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'メールアドレスを入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'パスワード',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'パスワードを入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: authController.isLoading ? null : _submit,
                          child: authController.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('ログイン'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
