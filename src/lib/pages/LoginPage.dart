import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:src/services/logger/Logger.dart';
import 'package:src/services/login/LoginService.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final serverURLController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Text('Login to your Trilium Server',
                style: Theme.of(context).textTheme.titleLarge),
            TextField(
              controller: serverURLController,
              decoration: InputDecoration(
                labelText: 'Server URL',
              ),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            TextButton(
                onPressed: _onLoginButtonPressed, child: const Text('Login')),
          ]))
    ]));
  }

  void _onLoginButtonPressed() async {
    try {
      await LoginService()
          .login(serverURLController.value.text, passwordController.value.text);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      Logger().reserLogThreads();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
