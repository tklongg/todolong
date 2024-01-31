import 'package:google_sign_in/google_sign_in.dart';

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
