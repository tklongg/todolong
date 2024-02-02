import 'package:flutter/material.dart';
import 'package:todolong/screens/Login/LoginScreenInput.dart';
import 'package:todolong/screens/Login/login_screen_start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todolong',
      
      home: const LoginScreenStart(),
      routes: {
        '/login_start': (context) => const LoginScreenStart(),
        '/login_input': (context) => const LoginScreenInput(),
      },
    );
  }
}


