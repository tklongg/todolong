import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final DateTime? dueDate;
  final ValueChanged<DateTime>? setDueDate;
  const ScheduleWidget({super.key, this.dueDate, this.setDueDate});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        // height: 40,
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 15,
              color: const Color(0xFF6D6D6D),
            ), // Icon của mục
            SizedBox(width: 5),
            Text("Today",
                style: const TextStyle(
                  color: Color(0xFF6D6D6D),
                  fontFamily: ".SF Pro Text",
                  fontSize: 16,
                )), // Label của mục
          ],
        ),
      ),
    );
  }
}
