import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreenStart extends StatefulWidget {
  const LoginScreenStart({super.key});

  @override
  State<LoginScreenStart> createState() => _LoginScreenStartState();
}

class _LoginScreenStartState extends State<LoginScreenStart> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppIcon(),
        Image(
          image: AssetImage('1.jpg'),
          height: 450,
          width: 250,
        ),
        Text('Organize your work and life, finally',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF010101),
              fontSize: 29,
              decoration: TextDecoration.none,
            )),
        OAuthForm()
      ],
    );
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD74638),
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('todoist_icon.png'),
              height: 55,
              width: 55,
            ),
            Text(
              'todolong',
              style: TextStyle(
                fontFamily: 'Roboto ',
                color: Color(0xFFD74638),
                fontSize: 36,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ));
  }
}

class OAuthForm extends StatelessWidget {
  const OAuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    void onPress() => {print(1)};
    return Column(
      children: [
        const SizedBox(height: 100),
        ElevatedButton.icon(
          onPressed: () => {onPress()},
          icon: FaIcon(
            FontAwesomeIcons.google,
            size: 16,
          ),
          label: Text("Continue with Google", style: TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: Size(300, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => {onPress()},
          icon: FaIcon(
            FontAwesomeIcons.apple,
            size: 17,
          ),
          label: Text(
            "Continue with Apple",
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: Size(300, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ],
    );
  }
}
