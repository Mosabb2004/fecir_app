import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../quiz/sinav_sayfasi.dart'; // Klasör: quiz

class OdevlerimSayfasi extends StatelessWidget {
  const OdevlerimSayfasi({super.key});

  Widget assignmentCard({
    required BuildContext context,
    required String title,
    required bool completed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: completed ? Colors.green.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(completed ? Icons.check : Icons.hourglass_bottom, color: completed ? Colors.green : Colors.orange),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(completed ? 'Tamamlandı' : 'Tamamlanmadı', style: TextStyle(color: completed ? Colors.green : Colors.orange)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mediumTeal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => SinavSayfasi(dersAdi: title))
              );
            },
            child: Text(completed ? 'Görüntüle' : 'Çöz', style: const TextStyle(color: Colors.white)),
          ),
        ],
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
        title: const Text('Ödevlerim', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            assignmentCard(context: context, title: 'Matematik Ödevi', completed: true),
            assignmentCard(context: context, title: 'Fizik Ödevi', completed: false),
            assignmentCard(context: context, title: 'Biyoloji Ödevi', completed: false),
          ],
        ),
      ),
    );
  }
}
