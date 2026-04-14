import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../login/giris_sayfasi.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({super.key});

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Çıkış Yap'),
          content: const Text('Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const GirisSayfasi()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        centerTitle: true,
        title: const Text('Profil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.lightAqua.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person, size: 50, color: AppColors.mediumTeal),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Öğrenci Adı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Öğrenci Numarası: #12345', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuItem(Icons.settings, 'Ayarlar', () {}),
                  _buildMenuItem(Icons.help_outline, 'Yardım ve Destek', () {}),
                  _buildMenuItem(Icons.info_outline, 'Hakkımızda', () {}),
                  const SizedBox(height: 20),
                  _buildMenuItem(Icons.logout, 'Çıkış Yap', _showLogoutDialog, isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.redAccent : AppColors.mediumTeal),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.redAccent : AppColors.petrolBlueDark,
            fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
