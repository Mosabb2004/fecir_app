import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../giris/giris_sayfasi.dart';

class MisafirAnaSayfasi extends StatefulWidget {
  const MisafirAnaSayfasi({super.key});

  @override
  State<MisafirAnaSayfasi> createState() => _MisafirAnaSayfasiState();
}

class _MisafirAnaSayfasiState extends State<MisafirAnaSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const GirisSayfasi()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: AppColors.mediumTeal,
              child: const Text(
                'Hoş Geldiniz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/yakinda.jpg', // Görsel güncellendi
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'Cuma sohbeti,\n'
                  'Akşam namazından sonra değil,\n'
                  'Yatsı namazından hemen sonraders.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    color: AppColors.petrolBlueDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bizimle İletişime Geçin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mediumTeal,
                  ),
                ),
                SizedBox(width: 20),
                Icon(Icons.call, color: AppColors.primaryGold, size: 30),
                SizedBox(width: 15),
                Icon(Icons.email, color: AppColors.primaryGold, size: 30),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
