import 'package:flutter/material.dart';

class LoginEmailWidget extends StatefulWidget {
  const LoginEmailWidget({super.key});

  @override
  State<LoginEmailWidget> createState() => _LoginEmailWidgetState();
}

class _LoginEmailWidgetState extends State<LoginEmailWidget> {
  // final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 24,
              fontFamily: "GGX88HV",
            ),
          ),
          const SizedBox(height: 17.0),
          const Text(
            'Add your email and password',
            style: TextStyle(
                fontSize: 16,
                fontFamily: "GGX88Reg_Light",
                color: Color(0xFF707070)),
          ),
          const SizedBox(height: 17.0),
          const Text(
            'YOUR EMAIL',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: "GGX88Reg_Light",
                color: Color(0xFF6e6e6e)),
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your email',
              hintStyle: TextStyle(
                fontFamily: "GGX88Reg_Light",
                color: Color(0xFFc6c6c6),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'YOUR PASSWORD',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: "GGX88Reg_Light",
                color: Color(0xFF6e6e6e)),
          ),
          TextField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter your password',
              hintStyle: const TextStyle(
                fontFamily: "GGX88Reg_Light",
                color: Color(0xFFc6c6c6),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Xử lý đăng nhập khi nhấn nút
              final email = _emailController.text;
              final password = _passwordController.text;
              // Thực hiện xác thực hoặc các bước đăng nhập khác ở đây
              print('Email: $email, Password: $password');
            },
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}
