import 'package:flutter/material.dart';
import 'AddUserScreen.dart';
import 'LaunchHistoryPage.dart';
import 'LaunchUpcomingPage.dart';
import 'UsersPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    Widget content = UsersPage();

    if (_currentIndex == 1) {
      content = LaunchUpcomingPage();
    } else if (_currentIndex == 2) {
      content = LaunchHistoryPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SpaceX Land",
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: content,
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                final route = MaterialPageRoute(
                  builder: (_) => AddUserScreen(),
                );

                final result = await Navigator.push(
                  context,
                  route,
                );

                if (result != null && result) {
                  // TODO: Have a better way of notifying this dashboard screen to fetch new data
                  setState(() {
                    _currentIndex = 0;
                  });
                }
              },
              backgroundColor: Color(0xFF005288),
              child: Icon(
                Icons.group_add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Users",
            icon: Icon(
              Icons.group,
              size: 16,
            ),
          ),
          BottomNavigationBarItem(
            label: "Upcoming",
            icon: Icon(
              Icons.track_changes,
              size: 16,
            ),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(
              Icons.history,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
