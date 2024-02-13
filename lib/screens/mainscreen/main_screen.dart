import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolong/screens/today/today_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    TodayScreen(),
    InboxScreen(),
    SearchScreen(),
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
              icon: Icon(Icons.search),
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
            showAddTodo();
          },
          shape: const CircleBorder(
              side: BorderSide(color: const Color.fromARGB(0, 255, 255, 255))),
          backgroundColor: const Color(0xFFD74638),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }

  void showAddTodo(){
    showModalBottomSheet(context: context, builder: (context){
      
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        color: Colors.white,
        child: Text("kk"),
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
        Icon(Icons.calendar_today),
        Positioned(
          child: Container(
            padding: EdgeInsets.fromLTRB(2, 5, 2, 2),
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
