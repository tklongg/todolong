import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider_pref.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool showTitle = false;
  void update() {
    setState() {
      showTitle = showTitle;
      print("refreshed");
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<Todo> alltodos = context.watch<TodoProvider>().getAllTodos();

    Map<DateTime, List<Todo>> todosByDate = new Map();
    // print(todosByDate);
    return CustomScrollView(
        // controller: _controller,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future<void>.delayed(const Duration(milliseconds: 500));
              update();
              // Add your refresh logic here
            },
          ),
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.2,
            title: Container(
              margin: const EdgeInsets.fromLTRB(0, 1, 9.0, 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: '.SF Pro Text',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      cursorColor: Color(0xFFD74638),
                      decoration: InputDecoration(
                        hintText: 'Enter your search query...',
                        hintStyle: TextStyle(
                            color: Colors.grey[800]), // Màu chữ xám đậm
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey[800]), // Màu icon xám đậm
                        fillColor: Colors.grey[200], // Background xám
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
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
          SliverToBoxAdapter(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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

    return groupedTodos;
  }
}
