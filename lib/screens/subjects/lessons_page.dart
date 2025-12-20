import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  Widget _lessonCard({
    required String title,
    required String lesson,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          /// LEFT BUTTON
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mediumTeal,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'حل الواجب',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.petrolBlueDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lesson,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/guest.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.mediumTeal,
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
          'الدروس',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ===== AQEEDA =====
              _sectionTitle('دروس العقيدة'),

              _lessonCard(
                title: 'عقيدتي',
                lesson: 'الدرس السادس – الإيمان بالملائكة',
                status: 'مكتمل',
                statusColor: Colors.green,
              ),
              _lessonCard(
                title: 'عقيدتي',
                lesson: 'الدرس السابع – الإيمان بالكتب',
                status: 'غير مكتمل',
                statusColor: Colors.red,
              ),
              _lessonCard(
                title: 'عقيدتي',
                lesson: 'الدرس الثامن – الإيمان بالرسل',
                status: 'غير مكتمل',
                statusColor: Colors.red,
              ),

              const SizedBox(height: 20),

              /// ===== FIQH =====
              _sectionTitle('دروس الفقه'),

              _lessonCard(
                title: 'فقهي',
                lesson: 'الدرس الأول – الطهارة',
                status: 'مكتمل',
                statusColor: Colors.green,
              ),
              _lessonCard(
                title: 'فقهي',
                lesson: 'الدرس الثاني – الصلاة',
                status: 'غير مكتمل',
                statusColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
