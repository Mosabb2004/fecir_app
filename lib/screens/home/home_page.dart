import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'my_assignments_page.dart';
import '../subjects/subjects_page.dart';
import '../tasmee/tasmee_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget homeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.mediumTeal,
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: AppColors.mediumTeal,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (badge != null)
              Positioned(
                top: 0,
                right: 0,
                child: badge,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,

      /// AppBar
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        title: const Text(
          'الصفحة الرئيسية',
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

      /// Body
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              'أهلاً وسهلاً',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.mediumTeal,
              ),
            ),

            const SizedBox(height: 30),

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                /// واجباتي
                homeCard(
                  context: context,
                  icon: Icons.edit_note,
                  title: 'واجباتي',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyAssignmentsPage(),
                      ),
                    );
                  },
                ),

                /// الدروس
                homeCard(
                  context: context,
                  icon: Icons.menu_book,
                  title: 'الدروس',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SubjectsPage(),
                      ),
                    );
                  },
                ),

                /// الإشعارات
                homeCard(
                  context: context,
                  icon: Icons.notifications,
                  title: 'إشعارات جديدة',
                  badge: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),

                /// التسميع
                homeCard(
                  context: context,
                  icon: Icons.headphones,
                  title: 'التسميع',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TasmeePage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'صفحة الواجبات سيتم إضافتها لاحقاً',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
