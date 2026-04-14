import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'odevlerim_sayfasi.dart';
import '../subjects/dersler_sayfasi.dart';
import '../tasmee/degerlendirme_sayfasi.dart';
import 'bildirimler_sayfasi.dart'; // Yeni dosya ismi

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  Widget homeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.mediumTeal,
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: AppColors.mediumTeal),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            if (badge != null) Positioned(top: 0, right: 0, child: badge),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        title: const Text('Ana Sayfa', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const BildirimlerSayfasi()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Hoş Geldiniz',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.mediumTeal),
            ),
            const SizedBox(height: 30),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                homeCard(
                  context: context,
                  icon: Icons.edit_note,
                  title: 'Ödevlerim',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const OdevlerimSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.menu_book,
                  title: 'Dersler',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DerslerSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.notifications,
                  title: 'Yeni Bildirim',
                  badge: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BildirimlerSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.analytics_outlined,
                  title: 'Performans Raporu',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DegerlendirmeSayfasi()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Gelişim raporunuzu buradan takip edebilirsiniz',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
