import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../quiz/sinav_sayfasi.dart'; // Yeni genel dosya

class DersDetaySayfasi extends StatelessWidget {
  final String subjectName;
  final String lessonNumber;
  final String topic;
  final String teacherName;
  final String imagePath;

  const DersDetaySayfasi({
    super.key,
    required this.subjectName,
    required this.lessonNumber,
    required this.topic,
    required this.teacherName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('$subjectName Detayı', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.petrolBlueDark,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(subjectName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(lessonNumber, style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 12),
                          Text(topic, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(teacherName, style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                    child: Image.asset(
                      imagePath,
                      width: 140,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(width: 140, color: Colors.grey[200], child: const Icon(Icons.image_not_supported)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mediumTeal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 4),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SinavSayfasi(dersAdi: subjectName)));
                },
                child: const Text('Ödevi Çöz', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Ödev Durumu: Çözülmedi / Tamamlandı', style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
