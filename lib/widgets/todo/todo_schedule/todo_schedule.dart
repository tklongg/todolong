import 'package:flutter/material.dart';
import 'package:todolong/models/todo.dart';

class TodoSchedule extends StatefulWidget {
  Todo? todo;
  Future<void>? onChangeSchedule;

  TodoSchedule({super.key, this.todo, this.onChangeSchedule});

  @override
  State<TodoSchedule> createState() => _TodoScheduleState();
}

class _TodoScheduleState extends State<TodoSchedule> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
       builder: (context, scrollController) {
        return Container(
          child: Text("oke"),
        );
       },
    );
  }
}
