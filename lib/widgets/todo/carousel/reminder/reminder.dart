import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderWidget extends StatelessWidget {
  final Duration? reminder;
  final ValueChanged<Duration>? setReminder;

  const ReminderWidget({super.key, this.reminder, this.setReminder});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: CupertinoTimerPicker(
                  initialTimerDuration: reminder ?? Duration.zero,
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (time) => {setReminder!(time)},
                ),
              );
            });
      },
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
            const Icon(
              Icons.timer_outlined,
              size: 15,
              color: Color(0xFF6D6D6D),
            ), // Icon của mục
            const SizedBox(width: 5),
            Text("${reminder?.inMinutes.remainder(60) ?? 0}m",
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
