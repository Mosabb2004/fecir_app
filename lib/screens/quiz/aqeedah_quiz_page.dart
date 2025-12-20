import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'quiz_result_page.dart';

class AqeedahQuizPage extends StatefulWidget {
  const AqeedahQuizPage({super.key});

  @override
  State<AqeedahQuizPage> createState() => _AqeedahQuizPageState();
}

class _AqeedahQuizPageState extends State<AqeedahQuizPage> {
  int currentQuestion = 1;
  final int totalQuestions = 3;

  int? selectedAnswer; // 🔥 الخيار المختار

  void _nextQuestion() {
    if (selectedAnswer == null) return;

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: const Text('هل أنت متأكد من إنهاء الواجب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لا'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mediumTeal,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuizResultPage(),
                ),
              );
            },
            child: const Text(
              'نعم',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget answerButton(int index) {
    final bool isSelected = selectedAnswer == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedAnswer = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mediumTeal
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          'جواب ${index + 1}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
          'واجب العقيدة 1',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question: $currentQuestion/$totalQuestions',
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 10),

            Text(
              'أسئلة $currentQuestion',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            answerButton(0),
            answerButton(1),
            answerButton(2),
            answerButton(3),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('الرجوع'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mediumTeal,
                  ),
                  onPressed: _nextQuestion,
                  child: const Text(
                    'التالي',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
