import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BildirimlerSayfasi extends StatelessWidget {
  const BildirimlerSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        title: const Text('Bildirimler'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            title: 'Yeni Ödev Eklendi',
            message: 'Matematik dersi için yeni bir ödeviniz var. Hemen göz atın!',
            time: '10 dakika önce',
            icon: Icons.edit_note,
            color: Colors.blue,
            isNew: true,
          ),
          _buildNotificationItem(
            title: 'Canlı Ders Başlıyor',
            message: 'Fizik canlı dersi 5 dakika içinde başlayacaktır.',
            time: '1 saat önce',
            icon: Icons.videocam,
            color: Colors.red,
            isNew: true,
          ),
          _buildNotificationItem(
            title: 'Performans Raporu Güncellendi',
            message: 'Hocanız son ders için değerlendirmelerini ekledi.',
            time: 'Dün',
            icon: Icons.analytics,
            color: Colors.green,
            isNew: false,
          ),
          _buildNotificationItem(
            title: 'Hoş Geldiniz!',
            message: 'El Fajr eğitim uygulamasına hoş geldiniz.',
            time: '2 gün önce',
            icon: Icons.celebration,
            color: AppColors.primaryGold,
            isNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
    required bool isNew,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNew ? color.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: isNew ? Border.all(color: color.withOpacity(0.3)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    if (isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'YENİ',
                          style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
