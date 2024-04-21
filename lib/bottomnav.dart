import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'Calender.dart';
import 'drawer.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => BottomNavPage();
}

class BottomNavPage extends State<BottomNav> with TickerProviderStateMixin {
  List screen = [Home(), Calendar(), MyDrawer()];

  int currentIndex = 0;
  int myindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[myindex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        currentIndex: myindex, // current index of tab
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Home Icon
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Calendar Icon
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Profile Icon
            label: 'Settings',
          ),
        ],
        selectedIconTheme:
            IconThemeData(color: Colors.brown), // Set color for selected icon
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedItemColor: Colors.brown, // Set color for unselected icon
      ),
    );
  }
}
