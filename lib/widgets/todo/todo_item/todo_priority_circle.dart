import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todolong/providers/todo_provider_pref.dart';

// class TodoPriorityCircle extends StatelessWidget {
//   final int prior;
//   const TodoPriorityCircle({super.key, required this.prior});

//   @override
//   Widget build(BuildContext context) {
//     Color borderColor;
//     Color fillColor;

//     switch (prior) {
//       case 1:
//         borderColor = const Color(0xFFD1453A); // Đỏ
//         fillColor = const Color.fromARGB(255, 255, 240, 239);
//         break;
//       case 2:
//         borderColor = const Color(0xFFEC8711); // Cam
//         fillColor = const Color(0xFFFAF4EA); // Màu da cam nhạt
//         break;
//       case 3:
//         borderColor = const Color(0xFF236FDE); // Xanh dương
//         fillColor = const Color(0xFFE9F0FB); // Màu xanh dương nhạt
//         break;
//       case 4:
//       default:
//         borderColor = Colors.grey; // Xám
//         fillColor = Colors.white; // Trắng
//     }

//     return Container(
//       width: 24, // Kích thước của hình tròn
//       height: 24,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle, // Hình dạng là hình tròn
//         border: Border.all(
//           color: borderColor,
//           width: 1.5,
//         ),
//         color: fillColor,
//       ),
//     );
//   }
// }
class TodoPriorityCircle extends StatefulWidget {
  final int prior;
  final VoidCallback handleClick;
  const TodoPriorityCircle(
      {Key? key, required this.prior, required this.handleClick})
      : super(key: key);

  @override
  _TodoPriorityCircleState createState() => _TodoPriorityCircleState();
}

class _TodoPriorityCircleState extends State<TodoPriorityCircle> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color fillColor;

    switch (widget.prior) {
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

    return GestureDetector(
      onTap: () {
        // setState(() {
        //   isChecked = true;
        // });
        HapticFeedback.vibrate();
        setState(() {
          isChecked = true;
        });
        Timer(const Duration(milliseconds: 500), () {
          widget.handleClick();
          setState(() {
            isChecked = false;
          });
        });
        // setState(() {
        //   isChecked = !isChecked;
        // });
        // widget.handleClick();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceIn,
        width: 24, // Kích thước của hình tròn
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Hình dạng là hình tròn
          border: Border.all(
            color: isChecked ? Colors.transparent : borderColor,
            width: 1.5,
          ),
          color: isChecked ? borderColor : fillColor,
        ),
        child: isChecked
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : null,
      ),
    );
  }
}
