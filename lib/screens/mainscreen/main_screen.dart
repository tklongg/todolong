import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolong/screens/all/all_todo.dart';
import 'package:todolong/screens/today/today_screen.dart';
import 'package:todolong/screens/upcoming/upcoming_screen.dart';
import 'package:todolong/utils/notification/notification_service.dart';
import 'package:todolong/widgets/todo/add_todo/add_todo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    const TodayScreen(),
    const UpcomingScreen(),
    const AllTodoScreen(),
    // BrowseScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        )),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFFD74638),
          selectedLabelStyle: const TextStyle(color: Color(0xFFD74638)),
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 150),
              curve: Curves.linearToEaseOut,
            );
          }
          // onTap: (index) {
          //   setState(() {
          //     _currentIndex = index;
          //   });
          // }
          ,
          items: [
            BottomNavigationBarItem(
              icon: buildTodayIcon(),
              label: 'Today',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'Upcoming',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox),
              label: 'All',
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.list_alt_rounded),
            //   label: 'Browse',
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NotificationService().showNotification(title: "ok", body: "ok");
            showAddTodo();
          },
          shape: const CircleBorder(
              side: BorderSide(color: Color.fromARGB(0, 255, 255, 255))),
          backgroundColor: const Color(0xFFD74638),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }

  void showAddTodo() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const AddTodo(
            parentId: null,
          );
        });
  }

  Widget buildTodayIcon() {
    // Lấy ngày hiện tại
    String currentDay = DateFormat.d().format(DateTime.now());
    // String currentDay = '29';

    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.calendar_today),
        Positioned(
          child: Container(
            padding: const EdgeInsets.fromLTRB(2, 5, 2, 2),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              currentDay,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: Center(
        child: Text('Inbox Screen'),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: Text('Search Screen'),
      ),
    );
  }
}

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse'),
      ),
      body: Center(
        child: Text('Browse Screen'),
      ),
    );
  }
}
