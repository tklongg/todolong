import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolong/models/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:todolong/widgets/auth/comment_widget.dart';
import 'package:todolong/widgets/today/comment_modal.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';

List<Todo> todoList = [
  Todo(
    id: 1,
    title: 'Buy groceries',
    description: 'Go to the supermarket and buy essential items.',
    priority: 2,
    dueDate: DateTime.now().add(const Duration(days: 1)),
    subtasks: [
      Todo(
        id: 2,
        title: 'Buy vegetables',
        description: 'Get fresh vegetables for the week.',
        priority: 1,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        subtasks: [],
      ),
      Todo(
        id: 3,
        title: 'Buy fruits',
        description: 'Get a variety of fruits.',
        priority: 1,
        dueDate: DateTime.now().add(Duration(days: 1)),
        subtasks: [],
      ),
    ],
  ),
  Todo(
    id: 4,
    title: 'Complete project',
    description: 'Finish the coding project by the deadline.',
    priority: 3,
    dueDate: DateTime.now().add(const Duration(days: 1)),
    subtasks: [
      Todo(
        id: 5,
        title: 'Write code',
        description: 'Implement the required features.',
        priority: 2,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        subtasks: [],
      ),
      Todo(
        id: 6,
        title: 'Test the application',
        description: 'Perform thorough testing.',
        priority: 2,
        dueDate: DateTime.now().add(Duration(days: 1)),
        subtasks: [],
      ),
    ],
  ),
];

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String formattedDate = '';
  bool isModalOpen = false;
  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('dd MMM - EEEE').format(DateTime.now());
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await Future<void>.delayed(
              const Duration(milliseconds: 500),
            );
            // Add your refresh logic here
          },
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(14.0, 9.0, 9.0, 9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: '.SF Pro Text',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 13.5,
                            fontFamily: '.SF Pro Text',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0XFFD0d0d0),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TodoItemWidget(
                        todo: todoList[index],
                        isModalOpen:
                            isModalOpen, // Truyền giá trị isModalOpen vào mỗi TodoItemWidget
                        onOpenModal: () {
                          setState(() {
                            isModalOpen = true; // Mở modalBottom
                          });
                          print("cout<<");
                          print(isModalOpen);
                        },
                        onCloseModal: () {
                          setState(() {
                            isModalOpen = false; // Đóng modalBottom
                          });
                          print("cout<<");
                          print(isModalOpen);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
