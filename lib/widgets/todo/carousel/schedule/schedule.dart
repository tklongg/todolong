import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final DateTime? dueDate;
  final ValueChanged<DateTime>? setDueDate;
  const ScheduleWidget({super.key, this.dueDate, this.setDueDate});
  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.black;
    Color textColor = Colors.black;
    String labelText = "Today";

    if (dueDate != null) {
      DateTime today = DateTime.now();
      DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
      DateTime yesterday = DateTime(today.year, today.month, today.day - 1);

      if (dueDate!.isBefore(yesterday)) {
        // Hôm qua
        iconColor = Colors.red;
        textColor = Colors.red;
        labelText = "Yesterday";
      } else if (dueDate!.isBefore(today)) {
        // Hôm nay
        iconColor = Colors.green;
        textColor = Colors.green;
        labelText = "Today";
      } else if (dueDate!.isBefore(tomorrow)) {
        // Ngày mai
        iconColor = Colors.yellow;
        textColor = Colors.yellow;
        labelText = "Tomorrow";
      } else {
        // Sau ngày mai
        iconColor = Colors.purple;
        textColor = Colors.purple;
        labelText = "Later";
      }
    }

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 15,
              color: iconColor,
            ), // Icon của mục
            SizedBox(width: 5),
            Text(
              labelText,
              style: TextStyle(
                color: textColor,
                fontFamily: ".SF Pro Text",
                fontSize: 16,
              ),
            ), // Label của mục
          ],
        ),
      ),
    );
  }
}
