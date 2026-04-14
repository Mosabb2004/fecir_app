import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SinavSonucSayfasi extends StatelessWidget {
  const SinavSonucSayfasi({super.key});

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
        title: const Text('Sınav Sonucu', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mediumTeal, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  Text(
                    'Değerlendirme',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '10/10',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.mediumTeal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 140,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mediumTeal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Kapat',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
