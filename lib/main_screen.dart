import 'package:flutter/material.dart';
import 'package:langlearn/learning/screens/start_screen.dart';
import 'package:langlearn/profile/maindrawer.dart';
import 'package:langlearn/rss/rss.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const StartScreen();
    if (_selectedPageIndex == 1) {
      activePage = const Rss();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learner'),
      ),
      drawer: const MainDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            label: 'Rss Feed',
          ),
        ],
      ),
    );
  }
}
