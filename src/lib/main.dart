import 'package:flutter/material.dart';
import 'package:src/pages/HomePage.dart';
import 'package:src/pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
      themeMode: ThemeMode.dark,
      title: 'Trilium Lite',
    );
  }
}

