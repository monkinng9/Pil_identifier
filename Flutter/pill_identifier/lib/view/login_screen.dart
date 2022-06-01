import 'package:flutter/material.dart';
import 'package:pill_identifier/service/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              authService.signInWithEmailAndPassword(
                emailController.text,
                passwordController.text,
              );
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              authService.signInWithGoogle();
            },
            child: const Text('Google Sign in'),
          ),
        ],
      ),
    );
  }
}
