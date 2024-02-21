import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider_pref.dart';

import 'package:todolong/widgets/todo/todo_item/todo_priority_circle.dart';
import 'package:todolong/widgets/todo/todo_modal.dart/todo_modal.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final int? type;
  final bool? isModalOpen;
  final VoidCallback? onOpenModal;
  final VoidCallback? onCloseModal;

  const TodoItemWidget({
    Key? key,
    required this.todo,
    this.type,
    this.isModalOpen,
    this.onOpenModal,
    this.onCloseModal,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) {
                Provider.of<TodoProvider>(context, listen: false)
                    .deleteTodo(todo.id!);
              },
              backgroundColor: const Color(0xFFD1453A),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          leading: CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {},
            child: buildTitle(context),
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
        ));
  }
  Widget buildTitle(context){
    if (type == 2){
      return const Icon(
          Icons.format_list_bulleted,
          size: 24,
          color: Colors.black38,
        );
        // const SizedBox(width: 20);
    }
    else {
      return TodoPriorityCircle(
              prior: todo.priority,
              handleClick: () {
                Provider.of<TodoProvider>(context, listen: false)
                    .completeTodo(todo.id!);
                print(todo.id!);
              },
            );
    }
  }
}
