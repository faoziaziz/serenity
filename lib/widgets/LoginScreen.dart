import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/widgets/homepage.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/providers/userState.dart';

import 'auth_service.dart';
import 'create_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserState, ScreenState>(
      builder: (context, userState, screenState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final message = await AuthService().login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (message!.contains('Sukses')) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  child: const Text('login'),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    userState.changeStateUserOwner(_emailController.text);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}
