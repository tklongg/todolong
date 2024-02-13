import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoPriorityCircle extends StatelessWidget {
  final int prior;
  const TodoPriorityCircle({super.key, required this.prior});

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color fillColor;

    switch (prior) {
      case 1:
        borderColor = const Color(0xFFD1453A); // Đỏ
        fillColor = const Color.fromARGB(255, 255, 240, 239);
        break;
      case 2:
        borderColor = const Color(0xFFEC8711); // Cam
        fillColor = const Color(0xFFFAF4EA); // Màu da cam nhạt
        break;
      case 3:
        borderColor = const Color(0xFF236FDE); // Xanh dương
        fillColor = const Color(0xFFE9F0FB); // Màu xanh dương nhạt
        break;
      case 4:
      default:
        borderColor = Colors.grey; // Xám
        fillColor = Colors.white; // Trắng
    }

    return Container(
      width: 24, // Kích thước của hình tròn
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Hình dạng là hình tròn
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        color: fillColor,
      ),
    );
  }
}
