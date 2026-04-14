import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class OnlineDerslerSayfasi extends StatelessWidget {
  const OnlineDerslerSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        title: const Text('Online Dersler'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Üst Bilgi Paneli
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.mediumTeal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: const [
                Icon(Icons.videocam, color: Colors.white, size: 50),
                SizedBox(height: 10),
                Text(
                  'Canlı Eğitim Merkezi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Google Meet üzerinden derslerinize katılın',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildOnlineLessonCard(
                  context: context,
                  subject: 'Matematik',
                  teacher: 'Ahmet Yılmaz',
                  time: '14:00 - 15:00',
                  isLive: true,
                ),
                _buildOnlineLessonCard(
                  context: context,
                  subject: 'Fizik',
                  teacher: 'Mehmet Demir',
                  time: '16:30 - 17:30',
                  isLive: false,
                ),
                _buildOnlineLessonCard(
                  context: context,
                  subject: 'Arapça',
                  teacher: 'Zeynep Kaya',
                  time: 'Yarın 10:00',
                  isLive: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineLessonCard({
    required BuildContext context,
    required String subject,
    required String teacher,
    required String time,
    required bool isLive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isLive ? Colors.red.withOpacity(0.1) : AppColors.lightAqua.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLive ? Icons.live_tv : Icons.event_available,
                color: isLive ? Colors.red : AppColors.mediumTeal,
              ),
            ),
            title: Text(
              subject,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.petrolBlueDark,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text('Öğretmen: $teacher'),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(time, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            trailing: isLive
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'CANLI',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Burada Google Meet linkine yönlendirme yapılacak
                },
                icon: const Icon(Icons.video_call),
                label: Text(isLive ? 'Şimdi Katıl' : 'Linke Git'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLive ? AppColors.primaryGold : AppColors.mediumTeal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
