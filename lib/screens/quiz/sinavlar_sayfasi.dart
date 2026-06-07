import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'sinav_sayfasi.dart';
import '../../services/auth_service.dart';
import '../../models/quiz.dart';

class SinavlarSayfasi extends StatefulWidget {
  const SinavlarSayfasi({super.key});

  @override
  State<SinavlarSayfasi> createState() => _SinavlarSayfasiState();
}

class _SinavlarSayfasiState extends State<SinavlarSayfasi> {
  List<Quiz> _quizzes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    final list = await AuthService.getQuizzes();
    if (mounted) {
      setState(() {
        _quizzes = list;
        _isLoading = false;
      });
    }
  }

  Widget quizCard({
    required BuildContext context,
    required Quiz quiz,
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
              color: AppColors.primaryGold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.quiz, color: AppColors.primaryGold),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(quiz.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                if (quiz.description != null) 
                  Text(quiz.description!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text('Süre: ${quiz.durationMinutes} Dk', style: const TextStyle(color: AppColors.mediumTeal, fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mediumTeal,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => SinavSayfasi(dersAdi: quiz.title))
              );
            },
            child: const Text('Başla', style: TextStyle(color: Colors.white)),
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
        title: const Text('Sınavlar', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : _quizzes.isEmpty 
          ? const Center(child: Text('Henüz atanmış bir sınavınız bulunmuyor.'))
          : RefreshIndicator(
              onRefresh: _loadQuizzes,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _quizzes.length,
                itemBuilder: (context, index) {
                  return quizCard(context: context, quiz: _quizzes[index]);
                },
              ),
            ),
    );
  }
}
