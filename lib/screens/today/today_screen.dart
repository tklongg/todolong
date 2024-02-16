import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolong/models/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:todolong/providers/todo_provider.dart';
import 'package:todolong/widgets/auth/comment_widget.dart';
import 'package:todolong/widgets/today/comment_modal.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';

List<Todo> todoList2 = [
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
    List<Todo> todoList = context.watch<TodoProvider>().getTodayTodos();
    List<Todo> todayTodos;
    List<Todo> overdueTodos;
    (todayTodos, overdueTodos) = context.watch<TodoProvider>().getTodayTodos2();
    print("cout<<");
    print(todoList);
    formattedDate = DateFormat('dd MMM - EEEE').format(DateTime.now());
    bool hasOverdueTasks = overdueTodos.isNotEmpty;
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: '.SF Pro Text',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),

                if (hasOverdueTasks)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(14.0, 0, 9.0, 0.0),
                        child: const Text(
                          "Overdue task",
                          style: TextStyle(
                              fontSize: 13.7,
                              fontFamily: '.SF Pro Text',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Color(0XFFD0d0d0),
                      ),
                    ],
                  ),

                Container(
                  margin: const EdgeInsets.all(0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: overdueTodos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TodoItemWidget(
                        todo: overdueTodos[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(14.0, 0, 9.0, 0.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 13.7,
                            fontFamily: '.SF Pro Text',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Color(0XFFD0d0d0),
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todayTodos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TodoItemWidget(
                        todo: todayTodos[index],
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
