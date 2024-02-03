import 'package:flutter/material.dart';
import 'package:todolong/screens/Preference/user_profile.dart';

class PreferenceSelectionScreen extends StatefulWidget {
  const PreferenceSelectionScreen({super.key});

  @override
  State<PreferenceSelectionScreen> createState() =>
      _PreferenceSelectionScreenState();
}

class _PreferenceSelectionScreenState extends State<PreferenceSelectionScreen> {
  Map<String, bool> preferences = {
    'Personal': false,
    'Work': false,
    'Education': false,
  };
  bool helpMeGetStarted = false;
  void _navigateToInputUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserProfileScreen(),
      ),
    );
  }

  bool isContinueButtonEnabled() {
    return preferences.containsValue(true);
  }

  @override
  Widget build(BuildContext context) {
    const double x = 30;
    const double y = 40;
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 17.0),
                const Text(
                  'How do you plan to use todolong?',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "GGX88HV",
                  ),
                ),
                const SizedBox(height: 17.0),
                const Text(
                  'Choose all that apply',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GGX88Reg_Light",
                      color: Color(0xFF707070)),
                ),
                const SizedBox(height: 17.0),
                Column(
                  children: [
                    CheckboxItem(
                        image: Image.asset('assets/1.jpg', height: x, width: y),
                        text: 'Personal'),
                    CheckboxItem(
                        image: Image.asset('assets/1.jpg', height: x, width: y),
                        text: 'Work'),
                    CheckboxItem(
                        image: Image.asset('assets/1.jpg', height: x, width: y),
                        text: 'Education'),
                  ],
                ),
                const SizedBox(height: 17.0),
                HelpSlider(),
                const SizedBox(height: 17.0),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isContinueButtonEnabled()
                          ? const Color(0xFFD74638)
                          : const Color(0xFFD74638),
                      minimumSize: const Size(double.infinity, 60),
                      
                    ),
                    onPressed: () {
                      _navigateToInputUserProfile();
                    },
                    child: const Text('Continue',style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GGX88Reg",
                      color: Colors.white,
                    ),
                  ),
                )),
              ],
            )));
  }

  Widget HelpSlider() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Màu của border
          width: 1.0, // Độ dày của border
        ),
        borderRadius: BorderRadius.circular(8.0), // Độ cong của border
      ),
      child: Row(
        children: [
          const Text(
            'Help me get started',
            style: TextStyle(
              fontSize: 15,
              fontFamily: "GGX88Reg_Light",
              color: Color(0xFF707070),
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: helpMeGetStarted,
              mouseCursor: SystemMouseCursors.click,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  helpMeGetStarted = value;
                });
                print("Cout<<");
                print(helpMeGetStarted);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget CheckboxItem({required Image image, required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Màu của border
          width: 1.0, // Độ dày của border
        ),
        borderRadius: BorderRadius.circular(8.0), // Độ cong của border
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Đặt checkbox về đầu
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                image,
                const SizedBox(width: 15.0, height: 60.0),
                Text(text,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: "GGX88Reg_Light",
                        color: Color(0xFF6e6e6e))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Checkbox(
              value: preferences[text],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              onChanged: (bool? value) {
                setState(() {
                  preferences[text] = value!;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
