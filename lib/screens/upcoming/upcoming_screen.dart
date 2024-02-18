import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';
import 'dart:math';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreensState();
}

class _UpcomingScreensState extends State<UpcomingScreen> {
  bool showTitle = false;
  final ScrollController _controller = ScrollController();
  void _scrollListener() {
    if (_controller.offset >= MediaQuery.of(context).size.height * 0.2 &&
        !showTitle) {
      setState(() {
        showTitle = true;
      });
      print('Reached the threshold!');
    } else if (_controller.offset < MediaQuery.of(context).size.height * 0.2 &&
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
  Widget build(BuildContext context) {
    List<Todo> upcomingTodos = context.watch<TodoProvider>().getUpcomingTodos();

    Map<DateTime, List<Todo>> todosByDate = _groupByDate(upcomingTodos);

    return CustomScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future<void>.delayed(const Duration(milliseconds: 500));
              // Add your refresh logic here
            },
          ),
          SliverToBoxAdapter(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!showTitle) ...{
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
                  } else ...{
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50, // Chiều cao của container
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'Fixed Container',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  },

                  // const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: todosByDate.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime date = todosByDate.keys.toList()[index];
                        List<Todo> todayTodos = todosByDate[date]!;

                        return _buildDaySection(context, date, todayTodos);
                      },
                    ),
                  )
                ],
              ),
            ]),
          )
        ]);
  }

  Widget _buildDaySection(
      BuildContext context, DateTime date, List<Todo> todos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(14.0, 0, 9.0, 0.0),
              child: Text(
                DateFormat('dd MMM - EEEE').format(date),
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
        Container(
          margin: const EdgeInsets.all(0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return TodoItemWidget(
                todo: todos[index],
              );
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        )
      ],
    );
  }

  Map<DateTime, List<Todo>> _groupByDate(List<Todo> todos) {
    Map<DateTime, List<Todo>> groupedTodos = {};

    for (var todo in todos) {
      DateTime date =
          DateTime(todo.dueDate!.year, todo.dueDate!.month, todo.dueDate!.day);
      if (!groupedTodos.containsKey(date)) {
        groupedTodos[date] = [];
      }
      groupedTodos[date]!.add(todo);
    }
    for (var i = 1; i <= 7; i++) {
      DateTime date = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + i);
      if (!groupedTodos.containsKey(date)) {
        groupedTodos[date] = [];
      }
    }
    return groupedTodos;
  }
}

// class UpcomingScreen extends StatelessWidget {
//   const UpcomingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Todo> upcomingTodos = context.watch<TodoProvider>().getUpcomingTodos();

//     Map<DateTime, List<Todo>> todosByDate = _groupByDate(upcomingTodos);

//     return CustomScrollView(
//       physics:
//           const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//       slivers: <Widget>[
//         CupertinoSliverRefreshControl(
//           onRefresh: () async {
//             await Future<void>.delayed(const Duration(milliseconds: 500));
//             // Add your refresh logic here
//           },
//         ),
//         SliverPersistentHeader(
//           floating: true,
//           delegate: SliverAppBarDelegate(
//             minHeight: 60,
//             maxHeight: 60,
//             child: Container(
//               color: Colors.red,
//               child: const Center(
//                 child: Text('This will hide'),
//               ),
//             ),
//           ),
//         ),
//         SliverPersistentHeader(
//           pinned: true,
//           delegate: SliverAppBarDelegate(
//             minHeight: 60.0,
//             maxHeight: 60.0,
//             child: Container(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               child: const Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 0.0,
//                       vertical: 0.0,
//                     ),
//                     child: Text('This will remain visible',
//                         style: TextStyle(fontSize: 20)),
//                   ),
//                   Divider(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               DateTime date = todosByDate.keys.toList()[index];
//               List<Todo> todos = todosByDate[date]!;
//               return _buildDaySection(context, date, todos);
//             },
//             childCount: todosByDate.length,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDaySection(
//       BuildContext context, DateTime date, List<Todo> todos) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(14.0, 0, 9.0, 0.0),
//               child: Text(
//                 DateFormat('dd MMM - EEEE').format(date),
//                 style: const TextStyle(
//                     fontSize: 13.7,
//                     fontFamily: '.SF Pro Text',
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Divider(
//               color: Color(0XFFD0d0d0),
//             ),
//           ],
//         ),
//         Container(
//           margin: const EdgeInsets.all(0),
//           child: ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: todos.length,
//             itemBuilder: (BuildContext context, int index) {
//               return TodoItemWidget(
//                 todo: todos[index],
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.05,
//         )
//       ],
//     );
//   }

//   Map<DateTime, List<Todo>> _groupByDate(List<Todo> todos) {
//     Map<DateTime, List<Todo>> groupedTodos = {};

//     for (var todo in todos) {
//       DateTime date =
//           DateTime(todo.dueDate!.year, todo.dueDate!.month, todo.dueDate!.day);
//       if (!groupedTodos.containsKey(date)) {
//         groupedTodos[date] = [];
//       }
//       groupedTodos[date]!.add(todo);
//     }
//     for (var i = 1; i <= 7; i++) {
//       DateTime date = DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day + i);
//       if (!groupedTodos.containsKey(date)) {
//         groupedTodos[date] = [];
//       }
//     }
//     return groupedTodos;
//   }
// }

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
