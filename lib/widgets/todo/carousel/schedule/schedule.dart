import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolong/widgets/todo/todo_schedule_picker/todo_schedule_picker.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
  bool isYesterday(DateTime other) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
  bool isBeforeYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isBefore(yesterday);
  }

  bool isTomorrow(DateTime other) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }
}

class ScheduleWidget extends StatelessWidget {
  final DateTime? dueDate;
  final ValueChanged<DateTime>? setDueDate;
  const ScheduleWidget({super.key, this.dueDate, this.setDueDate});
  @override
  Widget build(BuildContext context) {
    print(dueDate);
    Color iconColor = Colors.black;
    Color textColor = Colors.black;
    String labelText = "Today";

    if (dueDate != null) {
      DateTime today = DateTime.now();
      DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);

      if (DateOnlyCompare(dueDate!).isYesterday(today)) {
        iconColor = Colors.red;
        textColor = Colors.red;
        labelText = "Yesterday";
        // Hôm qua
      } else if (DateOnlyCompare(dueDate!).isBeforeYesterday()) {
        // Hôm nay
        iconColor = Colors.red;
        textColor = Colors.red;
        labelText = DateFormat('dd MMM').format(dueDate!);
      } else if (DateOnlyCompare(dueDate!).isSameDate(today)) {
        // Hôm nay
        iconColor = Colors.green;
        textColor = Colors.green;
        labelText = "Today";
      } else if (DateOnlyCompare(dueDate!).isTomorrow(today)) {
        // Ngày mai
        iconColor = Colors.orange;
        textColor = Colors.orange;
        labelText = "Tomorrow";
      } else if (dueDate!.isAfter(tomorrow)) {
        // Ngày mai
        iconColor = Colors.purple;
        textColor = Colors.purple;
        labelText = DateFormat('dd MMM').format(dueDate!);
      } 
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            useRootNavigator: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return TodoSchedulePicker(
                dueDate: dueDate,
                setDueDate: setDueDate,
              );
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
              Icons.calendar_today,
              size: 15,
              color: iconColor,
            ), // Icon của mục
            const SizedBox(width: 5),
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
