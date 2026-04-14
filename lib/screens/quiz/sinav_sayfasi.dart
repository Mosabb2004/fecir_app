import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'sinav_sonuc_sayfasi.dart'; // Yeni dosya ismi

class SinavSayfasi extends StatefulWidget {
  final String dersAdi;

  const SinavSayfasi({super.key, this.dersAdi = "Ders"});

  @override
  State<SinavSayfasi> createState() => _SinavSayfasiState();
}

class _SinavSayfasiState extends State<SinavSayfasi> {
  int currentQuestion = 1;
  final int totalQuestions = 3;
  int? selectedAnswer;

  void _nextQuestion() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir cevap seçin')),
      );
      return;
    }

    if (currentQuestion < totalQuestions) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      _showFinishDialog();
    }
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Testi Bitir'),
        content: const Text('Soruları tamamladınız, bitirmek istiyor musunuz?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hayır')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.mediumTeal),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SinavSonucSayfasi()));
            },
            child: const Text('Evet', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget answerButton(int index) {
    final bool isSelected = selectedAnswer == index;
    return InkWell(
      onTap: () => setState(() => selectedAnswer = index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mediumTeal : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          'Seçenek ${index + 1}',
          style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade700, fontSize: 16, fontWeight: FontWeight.w500),
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
        title: Text('${widget.dersAdi} Testi', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Soru: $currentQuestion/$totalQuestions', style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Text('${widget.dersAdi} Soru $currentQuestion', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            answerButton(0),
            answerButton(1),
            answerButton(2),
            answerButton(3),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Geri')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.mediumTeal),
                  onPressed: _nextQuestion,
                  child: const Text('İleri', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
