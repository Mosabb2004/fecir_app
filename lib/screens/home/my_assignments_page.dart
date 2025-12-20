import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../quiz/aqeedah_quiz_page.dart';

class MyAssignmentsPage extends StatelessWidget {
  const MyAssignmentsPage({super.key});

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          /// أيقونة الحالة
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: completed
                  ? Colors.green.withOpacity(0.15)
                  : Colors.orange.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed ? Icons.check : Icons.hourglass_bottom,
              color: completed ? Colors.green : Colors.orange,
            ),
          ),

          const SizedBox(width: 14),

          /// معلومات الواجب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  completed ? 'مكتمل' : 'غير مكتمل',
                  style: TextStyle(
                    color: completed ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          /// زر الدخول
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mediumTeal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AqeedahQuizPage(),
                ),
              );
            },
            child: Text(
              completed ? 'عرض' : 'حل',
              style: const TextStyle(color: Colors.white),
            ),
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
        title: const Text(
          'واجباتي',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            assignmentCard(
              context: context,
              title: 'واجب العقيدة 1',
              completed: true,
            ),
            assignmentCard(
              context: context,
              title: 'واجب العقيدة 2',
              completed: false,
            ),
            assignmentCard(
              context: context,
              title: 'واجب الفقه 1',
              completed: false,
            ),
          ],
        ),
      ),
    );
  }
}
