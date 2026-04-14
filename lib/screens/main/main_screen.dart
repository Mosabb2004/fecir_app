import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../ana_sayfa/ana_sayfa.dart'; // Klasör: ana_sayfa
import '../profile/profil_sayfasi.dart'; // Klasör: profile
import '../subjects/dersler_sayfasi.dart'; // Klasör: subjects
import '../subjects/online_dersler_sayfasi.dart';
import '../resources/kaynaklar_sayfasi.dart'; // Klasör: resources

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    ProfilSayfasi(), // Sınıf ismi: ProfilSayfasi
    DerslerSayfasi(), // Sınıf ismi: DerslerSayfasi
    AnaSayfa(),       // Sınıf ismi: AnaSayfa
    OnlineDerslerSayfasi(), // Sınıf ismi: OnlineDerslerSayfasi
    KaynaklarSayfasi(), // Sınıf ismi: KaynaklarSayfasi
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
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Dersler'),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Online'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_shared), label: 'Kaynaklar'),
        ],
      ),
    );
  }
}
