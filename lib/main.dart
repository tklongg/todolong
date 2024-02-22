import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolong/providers/settings_provider.dart';
import 'package:todolong/providers/todo_provider_pref.dart';
import 'package:todolong/screens/mainscreen/main_screen.dart';
import 'package:todolong/utils/notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();

  runApp(const MyApp());
}

ThemeData _baseTheme = ThemeData(
  fontFamily: "Roboto",
  canvasColor: Colors.transparent,
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   // NotificationService().init();
  // }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    print(dateTime.timeZoneName);
    print(dateTime.timeZoneOffset);

    // return ChangeNotifierProvider(
    //   create: ((context) => TodoProvider()),
    //   child: const MaterialApp(
    //     title: 'todolong',
    //     // theme: _baseTheme,
    //     // debugShowCheckedModeBanner: false,
    //     home: MainScreen(),
    //     // routes: {
    //     //   '/login_start': (context) => const LoginScreenStart(),
    //     //   '/preference_selection': (context) =>
    //     //       const PreferenceSelectionScreen(),
    //     //   '/user_profile': (context) => const UserProfileScreen(),
    //     // },
    //   ),
    // );
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
          ChangeNotifierProvider<SettingProvider>(create: (_) => SettingProvider()),
        ],
        child: const MaterialApp(
          title: 'todolong',
          // theme: _baseTheme,
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        ));
  }
}
