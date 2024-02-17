import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Upcoming'),
      ),
    );
  }
}
