import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'ders_detay_sayfasi.dart'; // Yeni dosya ismi

class DerslerSayfasi extends StatelessWidget {
  const DerslerSayfasi({super.key});

  Widget lessonCard({
    required BuildContext context,
    required String subjectName,
    required String lessonNumber,
    required String topic,
    required String teacherName,
    required String imagePath,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DersDetaySayfasi( // Yeni sınıf ismi
              subjectName: subjectName,
              lessonNumber: lessonNumber,
              topic: topic,
              teacherName: teacherName,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Metin Kısmı
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.petrolBlueDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      subjectName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lessonNumber,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      topic,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Görsel
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                width: 120,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
            ),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Dersler',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            lessonCard(
              context: context,
              subjectName: 'Matematik',
              lessonNumber: '1. Ders',
              topic: 'Sayılar ve İşlemler',
              teacherName: 'Ahmet Yılmaz',
              imagePath: 'assets/images/matematik.jpg',
            ),
            lessonCard(
              context: context,
              subjectName: 'Fizik',
              lessonNumber: '2. Ders',
              topic: 'Kuvvet ve Hareket',
              teacherName: 'Mehmet Demir',
              imagePath: 'assets/images/fizik.webp',
            ),
            lessonCard(
              context: context,
              subjectName: 'Biyoloji',
              lessonNumber: '3. Ders',
              topic: 'Hücre Yapısı',
              teacherName: 'Selin Aktaş',
              imagePath: 'assets/images/biyoloji.jpg',
            ),
            lessonCard(
              context: context,
              subjectName: 'Türkçe',
              lessonNumber: '4. Ders',
              topic: 'Dil Bilgisi',
              teacherName: 'Fatma Şahin',
              imagePath: 'assets/images/turkce.webp',
            ),
            lessonCard(
              context: context,
              subjectName: 'Arapça',
              lessonNumber: '5. Ders',
              topic: 'Temel Dil Bilgisi',
              teacherName: 'Zeynep Kaya',
              imagePath: 'assets/images/arapca.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
