import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class KaynaklarSayfasi extends StatelessWidget {
  const KaynaklarSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        title: const Text('Eğitim Kaynakları'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.mediumTeal,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Kaynak ara...',
                prefixIcon: const Icon(Icons.search, color: AppColors.mediumTeal),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildCategoryTitle('Ders Notları (PDF)'),
                _buildResourceItem('Matematik - Sayılar Notları', 'PDF - 2.4 MB', Icons.picture_as_pdf, Colors.red),
                _buildResourceItem('Fizik - Hareket Yasaları', 'PDF - 1.8 MB', Icons.picture_as_pdf, Colors.red),
                const SizedBox(height: 20),
                _buildCategoryTitle('Ek Kaynaklar'),
                _buildResourceItem('Arapça Kelime Listesi', 'Excel - 500 KB', Icons.table_chart, Colors.green),
                _buildResourceItem('Biyoloji Deney Videoları', 'Video Linki', Icons.play_circle_fill, Colors.blue),
                _buildResourceItem('Türkçe Yazım Kuralları', 'PDF - 1.2 MB', Icons.picture_as_pdf, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.petrolBlueDark)),
    );
  }

  Widget _buildResourceItem(String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.download_for_offline, color: AppColors.mediumTeal),
        onTap: () {},
      ),
    );
  }
}
