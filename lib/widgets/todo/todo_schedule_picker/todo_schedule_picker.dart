import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoSchedulePicker extends StatelessWidget {
  final DateTime? dueDate;
  final ValueChanged<DateTime>? setDueDate;
  const TodoSchedulePicker({super.key, this.dueDate, this.setDueDate});

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
                fontFamily: ".SF Pro Text"), // Selected Date landscape
            titleLarge:
                TextStyle(fontFamily: ".SF Pro Text"), // Selected Date portrait
            labelSmall:
                TextStyle(fontFamily: ".SF Pro Text"), // Title - SELECT DATE
            bodyLarge:
                TextStyle(fontFamily: ".SF Pro Text"), // year gridbview picker
            titleMedium: TextStyle(fontFamily: ".SF Pro Text"), // input
            titleSmall:
                TextStyle(fontFamily: ".SF Pro Text"), // month/year picker
            bodySmall: TextStyle(fontFamily: ".SF Pro Text"),
          ),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                // Title, selected date and day selection background (dark and light mode)
                // surface: Color(0xFFD74638),
                primary: const Color(0xFFD74638),
                // Title, selected date and month/year picker color (dark and light mode)
                // onSurface: Colors.black,
                // onPrimary: Colors.black,
              ),
        ),
        child: Wrap(children: [
          Container(
            color: Colors.white,
            child: Column(children: [
              CupertinoNavigationBar(
                border: Border.all(color: Colors.transparent),
                backgroundColor: Colors.white,
                leading: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Color(0xFFD1453A))),
                ),
                trailing: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                    if (setDueDate != null) {
                      setDueDate!(selectedDate ?? DateTime.now());
                    }
                  },
                  child: const Text('Done',
                      style: TextStyle(color: Color(0xFFD1453A))),
                ),
              ),
              CalendarDatePicker(
                  initialDate: dueDate,
                  lastDate: DateTime(2075, 12, 31),
                  firstDate: dueDate ?? DateTime.now(),
                  onDateChanged: (date) {
                    // print(date);
                    selectedDate = date;
                    // setDueDate!(date);
                    print("done");
                  }),
            ]),
          )
        ]));
  }
}
