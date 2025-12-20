import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'tasmee_history_page.dart';


class TasmeePage extends StatelessWidget {
  const TasmeePage({super.key});

  Widget progressRow(Color color) {
    return Row(
      children: const [
        Text('Surah | Date'),
        Spacer(),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        SizedBox(width: 6),
        Text('10/10'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,

      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        title: const Text('صفحة التسميع'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// بطاقة التقدم
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mediumTeal),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('📘 بطاقة التقدم'),
                  SizedBox(height: 8),
                  Text('عدد الصفحات: 12'),
                  Text('⭐ متوسط التقييم: ممتاز'),
                  Text('⏰ آخر تحديث: 12/9/2025'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// السور السابقة
            progressRow(Colors.red),
            progressRow(Colors.orange),
            progressRow(Colors.green),
            progressRow(Colors.green),

            const SizedBox(height: 30),

            /// زر التسميع (🔥 المصحّح)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mediumTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TasmeeHistoryPage(),
                    ),
                  );
                },
                child: const Text(
                  'التسميع',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// الإدخال
            TextField(
              decoration: InputDecoration(
                hintText: 'الواجب: السورة من إلى',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.mediumTeal,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'ملاحظات',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.mediumTeal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
