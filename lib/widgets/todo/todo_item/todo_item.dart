import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/widgets/todo/todo_item/todo_priority_circle.dart';
import 'package:todolong/widgets/todo/todo_modal.dart/todo_modal.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final bool isModalOpen; // Trạng thái mở/đóng của modalBottom
  final VoidCallback onOpenModal;
  final VoidCallback onCloseModal;

  const TodoItemWidget({
    Key? key,
    required this.todo,
    required this.isModalOpen,
    required this.onOpenModal,
    required this.onCloseModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {},
        child: buildPriorityCircleAvatar(todo.priority),
      ),
      title: Text(todo.title),
      onTap: () {
        onOpenModal();
        showModalBottomSheet<void>(
          isDismissible: true,
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          builder: (context) => PopScope(
            child: TodoModal(todo: todo),
            onPopInvoked: (didPop) {
              onCloseModal();
            },
          ),
        );
      },
    );
  }

  Widget buildPriorityCircleAvatar(int prior) {
    return TodoPriorityCircle(prior: prior);
  }
}
