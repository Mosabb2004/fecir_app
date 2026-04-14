import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../ana_sayfa/ana_sayfa.dart';
import '../profile/profil_sayfasi.dart';
import '../subjects/dersler_sayfasi.dart';
import '../subjects/online_dersler_sayfasi.dart';
import '../resources/kaynaklar_sayfasi.dart';

class AnaEkranSayfasi extends StatefulWidget {
  const AnaEkranSayfasi({super.key});

  @override
  State<AnaEkranSayfasi> createState() => _AnaEkranSayfasiState();
}

class _AnaEkranSayfasiState extends State<AnaEkranSayfasi> {
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    ProfilSayfasi(),
    DerslerSayfasi(),
    AnaSayfa(),
    OnlineDerslerSayfasi(),
    KaynaklarSayfasi(),
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
        selectedFontSize: 11,
        unselectedFontSize: 9,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26),
            activeIcon: Icon(Icons.person, size: 26),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined, size: 26),
            activeIcon: Icon(Icons.menu_book, size: 26),
            label: 'Dersler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Icon(Icons.home, size: 30),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam_outlined, size: 26),
            activeIcon: Icon(Icons.videocam, size: 26),
            label: 'Online',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared_outlined, size: 26),
            activeIcon: Icon(Icons.folder_shared, size: 26),
            label: 'Kaynaklar',
          ),
        ],
      ),
    );
  }
}
