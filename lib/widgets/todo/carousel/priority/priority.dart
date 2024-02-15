import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolong/widgets/todo/todo_priority_choose/todo_priority_choose.dart';

class PriorityWidget extends StatelessWidget {
  final int? priority;
  final ValueChanged<int>? setPriority;
  const PriorityWidget({super.key, this.priority, this.setPriority});
  @override
  Widget build(BuildContext context) {
    print("cout<<prior");
    print(priority);
    Color iconColor = Colors.black;
    Color textColor = Colors.black;
    String labelText = "Priority";
    switch (priority) {
      case 1:
        iconColor = const Color(0xFFD1453A);
        textColor = const Color(0xFFD1453A);
        labelText = "Priority 1";
        break;
      case 2:
        iconColor = const Color(0xFFEC8711);
        textColor = const Color(0xFFEC8711);
        labelText = "Priority 2";
        break;
      case 3:
        iconColor = const Color(0xFF236FDE);
        textColor = const Color(0xFF236FDE);
        labelText = "Priority 3";
        break;
      case 4:
        iconColor = const Color(0xFFA3A3A3);
        textColor = const Color(0xFFA3A3A3);
        labelText = "Priority 4";
        break;
      default:
        iconColor = Colors.black;
        textColor = Colors.black;
        labelText = "Priority";
    }
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return TodoPriorityChoose(
                  priority: priority, setPriority: setPriority);
            });
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        // height: 40,
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.flag,
              size: 15,
              color: iconColor,
            ), // Icon của mục
            const SizedBox(width: 5),
            Text(labelText,
                style: TextStyle(
                  color: textColor,
                  fontFamily: ".SF Pro Text",
                  fontSize: 16,
                )), // Label của mục
          ],
        ),
      ),
    );
  }
}
