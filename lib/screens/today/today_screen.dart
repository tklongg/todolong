import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider_pref.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String formattedDate = '';
  bool showTitle = false;
  final ScrollController _controller = ScrollController();
  void _scrollListener() {
    if (_controller.offset >= MediaQuery.of(context).size.height * 0.01 &&
        !showTitle) {
      setState(() {
        showTitle = true;
      });
      print('Reached the threshold!');
    } else if (_controller.offset < MediaQuery.of(context).size.height * 0.01 &&
        showTitle) {
      setState(() {
        showTitle = false;
      });
      print('Not reach the threshold!');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // bool isModalOpen = false;
  @override
  Widget build(BuildContext context) {
    List<Todo> todayTodos;
    List<Todo> overdueTodos;
    (todayTodos, overdueTodos) = context.watch<TodoProvider>().getTodayTodos2();

    // print("cout<<");
    // print(todoList);
    void updateTodayTodos() {
      setState(() {
        print("refreshed");
      });
    }

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
            updateTodayTodos();
            // Add your refresh logic here
          },
        ),
        if (showTitle) ...{
          SliverAppBar(
            title: const Center(
                child: Text('Todo', style: TextStyle(fontSize: 20))),

            expandedHeight: MediaQuery.of(context).size.height * 0.05,
            // Không bật động tác tự động co/expand
            floating: false,

            pinned: true,

            backgroundColor: Colors.white,

            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
            ),
          ),
        } else ...{
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: Container(
              margin: const EdgeInsets.fromLTRB(0, 1, 9.0, 9.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Todo',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: '.SF Pro Text',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ),

            expandedHeight: MediaQuery.of(context).size.height * 0.05,
            // Không bật động tác tự động co/expand

            backgroundColor: Colors.white,

            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
            ),
          ),
        },
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   margin: const EdgeInsets.fromLTRB(14.0, 9.0, 9.0, 9.0),
                //   child: const Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 20),
                //       Text(
                //         'Today',
                //         style: TextStyle(
                //           fontSize: 30,
                //           fontFamily: '.SF Pro Text',
                //           fontWeight: FontWeight.w800,
                //         ),
                //       ),
                //       SizedBox(height: 10),
                //     ],
                //   ),
                // ),

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
                    physics: const NeverScrollableScrollPhysics(),
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
                    physics: const NeverScrollableScrollPhysics(),
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
