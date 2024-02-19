import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderWidget extends StatelessWidget {
  final Duration? reminder;
  final ValueChanged<Duration?>? setReminder;

  const ReminderWidget({super.key, this.reminder, this.setReminder});
  @override
  Widget build(BuildContext context) {
    Duration? selectedReminder = reminder;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Wrap(children: [
                Container(
                  color: Colors.white,
                  child: Column(children: [
                    CupertinoNavigationBar(
                      border: Border.all(color: Colors.transparent),
                      backgroundColor: Colors.white,
                      leading: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          showCupertinoDialog(
                              // barrierDismissible: true,
                              // barrierLabel: "ok",

                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                    title: const Text("Remove reminder?",
                                        style: TextStyle(
                                            color: Color(0xFFD1453A))),
                                    content: const Text(
                                        "You want this todo to not remind you?"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: const Text("Cancel",
                                            style: TextStyle(
                                                color: Color(0xFFD1453A))),
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                      ),
                                      CupertinoDialogAction(
                                          child: const Text("Ok",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 46, 133, 231))),
                                          onPressed: () {
                                            setReminder!(null);
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  ));
                          // Navigator.pop(context);
                        },
                        child: const Text('Cancel reminder',
                            style: TextStyle(color: Color(0xFFD1453A))),
                      ),
                      trailing: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.pop(context);
                          if (setReminder != null) {
                            setReminder!(selectedReminder ?? Duration.zero);
                          }
                        },
                        child: const Text('Done',
                            style: TextStyle(color: Color(0xFFD1453A))),
                      ),
                    ),
                    CupertinoTimerPicker(
                      initialTimerDuration: reminder ?? Duration.zero,
                      mode: CupertinoTimerPickerMode.hm,
                      onTimerDurationChanged: (time) => {
                        {selectedReminder = time}
                      },
                    ),
                  ]),
                )
              ]);
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
            const Icon(
              Icons.timer_outlined,
              size: 15,
              color: Color(0xFF6D6D6D),
            ), // Icon của mục
            const SizedBox(width: 5),
            Text(
                "${reminder?.inHours.remainder(60) ?? 0}h ${reminder?.inMinutes.remainder(60) ?? 0}m",
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
