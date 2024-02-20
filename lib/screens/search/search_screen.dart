import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolong/models/todo.dart';
import 'package:todolong/providers/todo_provider_pref.dart';
import 'package:todolong/utils/prefs/search_pref.dart';
import 'package:todolong/widgets/search/recent_search.dart';
import 'package:todolong/widgets/todo/todo_item/todo_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // String searchString = '';

  List<Todo> titleMatch = [];
  List<Todo> descMatch = [];
  void handleSearch(String searchString) {
    List<Todo> t1;
    List<Todo> t2;
    (t1, t2) = Provider.of<TodoProvider>(context, listen: false)
        .searchTodoByTitle(searchString);
    print(t1);
    print(t2);
    setState(() {
      titleMatch = t1;
      descMatch = t2;
    });
  }

  void update() {
    setState(() {
      print("refreshed");
    });
  }

  Future<List<String>> fetchData() async {
    // Simulated delay of 2 seconds
    return await SearchPreferences().getSearchPref();
  }

  @override
  Widget build(BuildContext context) {
    // List<Todo> alltodos = context.watch<TodoProvider>().getAllTodos();
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
            toolbarHeight: MediaQuery.of(context).size.height * 0.25,
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
                    child: TextFormField(
                        cursorColor: const Color(0xFFD74638),
                        decoration: const InputDecoration(
                          hintText: 'Title, Description and More',
                          hintStyle: TextStyle(color: Color(0xFF807F81)),
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFF807F81)),
                          fillColor: Color(0xFFEEEEF0),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onFieldSubmitted: (value) async {
                          if (value != "") {
                            handleSearch(value);
                            await SearchPreferences().addSearchPref(value);
                          }
                        }),
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.05,
            backgroundColor: Colors.white,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(children: [
              const SizedBox(height: 120),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(9.0, 0, 9.0, 0.0),
                        child: const Text(
                          "Recently Search",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: '.SF Pro Text',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Color(0XFFD0d0d0),
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("error fetching recently search"),
                        );
                      } else {
                        List<String> data = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RecentSearchBtn(data: data[index]);
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(9.0, 0, 9.0, 0.0),
                        child: const Text(
                          "Tasks",
                          style: TextStyle(
                              fontSize: 15,
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
                      itemCount: titleMatch.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TodoItemWidget(
                          todo: titleMatch[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(9.0, 0, 9.0, 0.0),
                        child: const Text(
                          "Descriptions",
                          style: TextStyle(
                              fontSize: 15,
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
                      itemCount: descMatch.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TodoItemWidget(
                          todo: descMatch[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]),
          )
        ]);
  }
  
}


