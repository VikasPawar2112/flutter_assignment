import 'package:flutter/material.dart';
import 'package:flutter_app_assignment/screens/HomeScreen.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            HomeScreen(),
            Text('My Policies'),
            Text('Local Hospital'),
            Text('Raise Claim'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // this will be set when a new tab is tapped
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
            ),
            title: Text(
              'My Policies',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_hospital,
            ),
            title: Text(
              'Local Hospital',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
            ),
            title: Text(
              'Raise Claim',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
            ),
            title: Text(
              'Book Services',
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Colors.white,
        child: new Icon(
          Icons.home,
          color: Colors.grey,
          size: 40,
        ),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
