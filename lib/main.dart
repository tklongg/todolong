import 'package:flutter/material.dart';
import 'package:todolong/screens/Preference/preference_selection.dart';
import 'package:todolong/screens/Preference/user_profile.dart';
import 'package:todolong/screens/login/login_screen_start.dart';

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
      home: const PreferenceSelectionScreen(),
      routes: {
        '/login_start': (context) => const LoginScreenStart(),
        '/preference_selection': (context) => const PreferenceSelectionScreen(),
        '/user_profile': (context) => const UserProfileScreen(),
      },
    );
  }
}
