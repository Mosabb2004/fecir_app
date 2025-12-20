import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class TasmeeHistoryPage extends StatelessWidget {
  const TasmeeHistoryPage({super.key});

  Widget _row(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Surah | Date',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Text('⭐⭐⭐⭐⭐ 10/10'),
          const SizedBox(width: 10),
          Icon(Icons.square, size: 14, color: color),
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
        title: const Text(
          'أخر التسميع',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _row(Colors.red),
            _row(Colors.amber),
            _row(Colors.green),
            _row(Colors.green),
            _row(Colors.red),
            _row(Colors.amber),
            _row(Colors.green),
            _row(Colors.green),
          ],
        ),
      ),
    );
  }
}
