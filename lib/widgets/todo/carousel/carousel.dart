import 'package:flutter/material.dart';
import 'package:todolong/widgets/todo/carousel/label/label.dart';
import 'package:todolong/widgets/todo/carousel/location/location.dart';
import 'package:todolong/widgets/todo/carousel/priority/priority.dart';
import 'package:todolong/widgets/todo/carousel/reminder/reminder.dart';
import 'package:todolong/widgets/todo/carousel/schedule/schedule.dart';

// class Carousels extends StatefulWidget {
//   DateTime? dueDate;
//   int? priority;
//   List<String>? labels;
//   Carousel({super.key, this.dueDate, this.priority, this.labels});
//   @override
//   State<Carousel> createState() => _CarouselState();
// }

// class _CarouselState extends State<Carousel> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: const [
//           ScheduleWidget(),
//           PriorityWidget(),
//           ReminderWidget(),
//           LabelWidget(),
//           LocationWidget()
//         ],
//       ),
//     );
//   }
// }

class Carousel extends StatelessWidget {
  final DateTime? dueDate;
  final int? priority;
  final DateTime? reminder;
  final ValueChanged<DateTime>? setDueDate;
  final ValueChanged<int>? setPriority;
  final ValueChanged<DateTime>? setReminder;
  const Carousel(
      {super.key,
      this.dueDate,
      this.priority,
      this.reminder,
      this.setDueDate,
      this.setPriority,
      this.setReminder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ScheduleWidget(dueDate: dueDate, setDueDate: setDueDate),
          PriorityWidget(priority: priority,setPriority: setPriority),
          ReminderWidget(reminder: reminder, setReminder: setReminder),
          const LabelWidget(),
          const LocationWidget()
        ],
      ),
    );
  }
}
