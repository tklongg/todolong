import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OAuthForm extends StatelessWidget {
  const OAuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    Future signInGoogle() async {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      try {
        final GoogleSignInAccount? a = await googleSignIn.signIn();
        print(a);
      } catch (error) {
        print("cout<<");
        print(error);
      }
    }

    ;
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: signInGoogle,
          icon: SizedBox(
            width: 16,
            height: 16,
            child: SvgPicture.asset(
              'assets/google_icon.svg', // Thay đổi đường dẫn tệp SVG tùy thuộc vào vị trí của bạn
              // Màu của biểu tượng
            ),
          ),
          label: const Text("Continue with Google",
              style: TextStyle(fontSize: 19,fontFamily: "GGX88Reg"
              )),
          style: ElevatedButton.styleFrom( 
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: const Size(300, 50),
            
            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.circular(5),

              
              
            ),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () => {},
          icon: const FaIcon(
            FontAwesomeIcons.apple,
            size: 16,
          ),
          label: const Text(
            "Continue with Apple",
            style: TextStyle(fontSize: 19,fontFamily: "GGX88Reg"),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(300, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
