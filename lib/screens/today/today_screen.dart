import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print(1);
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'GGX88HV',
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'to todolong',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SF_Regular',
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Date: ${DateTime.now().toString()}',
                style: TextStyle(
                  fontFamily: 'GGX88Reg_Light',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
