import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider.dart';

import 'package:todolong/widgets/todo/todo_item/todo_priority_circle.dart';
import 'package:todolong/widgets/todo/todo_modal.dart/todo_modal.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  // final int? id;
  final bool? isModalOpen;
  final VoidCallback? onOpenModal;
  final VoidCallback? onCloseModal;

  const TodoItemWidget({
    Key? key,
    required this.todo,
    // this.id,
    this.isModalOpen,
    this.onOpenModal,
    this.onCloseModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      leading: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {},
        child: TodoPriorityCircle(
          prior: todo.priority,
          handleClick: () {
            Provider.of<TodoProvider>(context, listen: false)
                .completeTodo(todo.id!);
          },
        ),
      ),
      title: Text(
        todo.title,
        style: const TextStyle(
          fontFamily: ".SF Pro Text",
          fontSize: 20,
        ),
      ),
      onTap: () {
        if (onOpenModal != null) {
          onOpenModal!();
        }

        showModalBottomSheet<void>(
          isDismissible: true,
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          builder: (context) => PopScope(
            child: TodoModal(id: todo.id!),
            onPopInvoked: (didPop) {
              // onCloseModal();
              if (onCloseModal != null) {
                onCloseModal!();
              }
            },
          ),
        );
      },
    );
  }
}
