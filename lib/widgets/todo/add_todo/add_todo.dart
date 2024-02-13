import 'package:flutter/cupertino.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  DateTime? dueDate;
  int priority = 4;
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget buildCarousel(){
    return const Placeholder();
  }
}