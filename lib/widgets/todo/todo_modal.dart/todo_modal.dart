import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider.dart';
import 'package:todolong/widgets/today/comment_modal.dart';
import 'package:todolong/widgets/todo/todo_item_detail/todo_item_detail.dart';

class TodoModal extends StatelessWidget {
  // final Todo todo;
  final int id;
  const TodoModal({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Todo todo =
        Provider.of<TodoProvider>(context, listen: false).getTodoById(id);
    print(todo);
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 1,
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              // alignment: Alignment.topCenter,
              children: [
                buildDragContainer(context),
                TodoItemDetail(todo: todo),
                buildCommentButton(context)
              ],
            )));
  }

  void _showCommentModal(context) {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: true,
      builder: (context) => PopScope(
        child: const CommentModal(),
        onPopInvoked: (didPop) {
          // onCloseModal();
        },
      ),
    );
  }

  Widget buildDragContainer(ctx) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(ctx).size.width * 0.12,
          margin: const EdgeInsets.all(5),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0XFFD0d0d0),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            height: 5.5,
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }

  Widget buildCommentButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCommentModal(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFF7f7f7),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFF7f7f7),
          ),
          padding: const EdgeInsets.all(5.0),
          child: const Text(
            'Your comment here', // Nội dung của thanh comment
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildTodoDetail(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.green,
          child: const Column(children: [
            Text("Priority Circle + title"),
            Text("Icon Description + desc"),
            Text("Schedule"),
            Text("priority"),
            Text("carousel"),
            Text("subtask widget"),
            Text("comments (show latest)"),
          ]),
        ),
      ),
    );
  }
}
