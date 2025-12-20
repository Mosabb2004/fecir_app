import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../subjects/subjects_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // HomePage başlangıç

  static const List<Widget> _widgetOptions = <Widget>[
    ProfilePage(),   // Index 0
    HomePage(),      // Index 1
    SubjectsPage(),  // Index 2
    Center(
      child: Text(
        'Quran Content Here',
        style: TextStyle(fontSize: 30, color: Colors.grey),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.petrolBlueDark,
        selectedItemColor: AppColors.primaryGold,
        unselectedItemColor: AppColors.darkGray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 30),
            label: '',
          ),
        ],
      ),
    );
  }
}
