import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolong/utils/oauth/sign_in_google.dart';
import 'package:todolong/utils/screen.dart';
import 'package:todolong/widgets/auth/login_widget.dart';

// <div>Icons made from <a href="https://www.onlinewebfonts.com/icon">svg icons</a>is licensed by CC BY 4.0</div>
class LoginScreenStart extends StatefulWidget {
  const LoginScreenStart({super.key});

  @override
  State<LoginScreenStart> createState() => _LoginScreenStartState();
}

class _LoginScreenStartState extends State<LoginScreenStart> {
  // bool isMoreOptionsVisible = false;
  final moreOptionsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenUtil.screenHeight(context);
    double screenWidth = ScreenUtil.screenWidth(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              const AppIcon(),
              const Image(
                image: AssetImage('assets/1.jpg'),
                height: 400,
                width: 350,
              ),
              _buildSlogan(),
              _buildOauthForm(),
              InkWell(
                key: moreOptionsKey,
                child: const Text('More sign-in options',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF010101),
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    )),
                onTap: () {
                  // showModalBottomSheet<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return _buildModalOptions(context);
                  //   },
                  // );
                  showMoreOptions(context);
                },
              ),
            ],
          ),
        ));
  }

  void showMoreOptions(BuildContext context) async {
    final RenderBox renderBox =
        moreOptionsKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        const PopupMenuItem(
          value: 'login_facebook',
          child: Text('Continue with Facebook'),
        ),
        const PopupMenuItem(
          value: 'login_email',
          child: Text('Continue with email'),
        ),
        const PopupMenuItem(
          value: 'register_email',
          child: Text('Sign up with email'),
        ),
      ],
    );
    if (result != null) {
      print("null");
      if (result == 'login_facebook') {
        // Xử lý khi nhấn vào Đăng nhập với Facebook
        print("login_face");
      } else if (result == 'login_email') {
        print(3);
        _showEmailLoginModal();
        // Xử lý khi nhấn vào Đăng nhập với Email
      } else if (result == 'register_email') {
        print(4);
        // Xử lý khi nhấn vào Đăng ký với Email
      }
    }
  }

  void _showEmailLoginModal() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      useSafeArea: true,
      context: moreOptionsKey.currentContext!,
      builder: (BuildContext context) {
        return _buildEmailLoginModal(context);
      },
    );
  }

  Widget _buildEmailLoginModal(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
        height: height*0.9,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginEmailWidget(),
              
            ],
          ),
        ));
  }

  Widget _buildSlogan() {
    return Container(
      margin: const EdgeInsets.fromLTRB(75, 0, 75, 0),
      alignment: Alignment.center,
      child: const Text('Organize your work and life, finally',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'GGX88HV',
            color: Color(0xFF010101),
            fontSize: 22,
            decoration: TextDecoration.none,
          )),
    );
  }

  Widget _buildOauthForm() {
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
              style: TextStyle(fontSize: 19, fontFamily: "GGX88Reg")),
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
            style: TextStyle(fontSize: 19, fontFamily: "GGX88Reg"),
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

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double getFontSize(double size) =>
        size * (screenHeight + screenWidth) / 828;
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD74638),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/todoist_icon.png'),
              height: 55,
              width: 55,
            ),
            Text(
              'todolong',
              style: TextStyle(
                fontFamily: 'GGX88HV',
                color: const Color(0xFFD74638),
                fontSize: getFontSize(20),
                decoration: TextDecoration.none,
              ),
            )
          ],
        ));
  }
}

class SignInOptions extends StatelessWidget {
  const SignInOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nhấn vào tùy chọn Đăng nhập với Facebook
              },
              child: Text('Đăng nhập với Facebook'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nhấn vào tùy chọn Đăng nhập với Email
              },
              child: Text('Đăng nhập với Email'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nhấn vào tùy chọn Đăng ký với Email
              },
              child: Text('Đăng ký với Email'),
            ),
          ],
        ));
  }
}
