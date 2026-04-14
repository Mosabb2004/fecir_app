import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DegerlendirmeSayfasi extends StatelessWidget {
  const DegerlendirmeSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        title: const Text('Öğrenci Değerlendirme'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: AppColors.mediumTeal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: AppColors.mediumTeal),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Öğrenci Performans Özeti',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSummaryStat('Genel Başarı', '%85'),
                      const SizedBox(width: 30),
                      _buildSummaryStat('Ödevler', '12/15'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ders Notları ve Değerlendirmeler',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.petrolBlueDark),
                  ),
                  const SizedBox(height: 15),
                  _buildEvaluationCard('Matematik', 90, 'Harika ilerleme, ödevlerini aksatmadan yapıyor.'),
                  _buildEvaluationCard('Fizik', 75, 'Konuları anlıyor ancak daha fazla pratik yapmalı.'),
                  _buildEvaluationCard('Biyoloji', 85, 'Hücre yapısı konusundaki başarısı çok iyi.'),
                  _buildEvaluationCard('Arapça', 95, 'Ezberleri ve dil bilgisi mükemmel seviyede.'),
                  _buildEvaluationCard('Türkçe', 80, 'Kompozisyon yazımında gelişim gösteriyor.'),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.primaryGold, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }

  Widget _buildEvaluationCard(String subject, double grade, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.mediumTeal)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: grade >= 80 ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Not: ${grade.toInt()}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: grade >= 80 ? Colors.green : Colors.orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: grade / 100, backgroundColor: Colors.grey[200], color: grade >= 80 ? Colors.green : Colors.orange, minHeight: 6),
          const SizedBox(height: 12),
          Text(comment, style: const TextStyle(color: Colors.black54, fontSize: 13, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
