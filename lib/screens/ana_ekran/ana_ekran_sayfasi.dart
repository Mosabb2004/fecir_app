import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
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

  final List<Widget> _widgetOptions = [
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
      extendBody: true, // Content flows behind the floating navigation bar
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        decoration: BoxDecoration(
          color: AppColors.emeraldDeep.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primaryGold.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.primaryGold,
            unselectedItemColor: Colors.white.withOpacity(0.45),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 11,
            unselectedFontSize: 9,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
            unselectedLabelStyle: const TextStyle(letterSpacing: 0.5),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline, size: 24),
                activeIcon: const Icon(Icons.person, size: 24),
                label: AppLocalizations.of(context)!.profile,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu_book_outlined, size: 24),
                activeIcon: const Icon(Icons.menu_book, size: 24),
                label: AppLocalizations.of(context)!.lessons,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: AppColors.goldGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGold.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.home_filled, size: 22, color: Colors.white),
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.videocam_outlined, size: 24),
                activeIcon: const Icon(Icons.videocam, size: 24),
                label: AppLocalizations.of(context)!.online,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.folder_shared_outlined, size: 24),
                activeIcon: const Icon(Icons.folder_shared, size: 24),
                label: AppLocalizations.of(context)!.resources,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
