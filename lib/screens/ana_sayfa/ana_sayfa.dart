import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../services/auth_service.dart';
import 'odevlerim_sayfasi.dart';
import '../subjects/dersler_sayfasi.dart';
import '../resources/kaynaklar_sayfasi.dart';
import '../tasmee/degerlendirme_sayfasi.dart';
import 'bildirimler_sayfasi.dart';
import '../quiz/sinavlar_sayfasi.dart';
import '../yoklama/yoklama_sayfasi.dart';
import '../tasmee/degerlendirme_gecmisi_sayfasi.dart';
import '../tasmee/gelecek_oturumlar_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _unreadNotifications = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadNotifications();
  }

  Future<void> _loadUnreadNotifications() async {
    final list = await AuthService.getNotifications();
    if (mounted) {
      setState(() {
        _unreadNotifications = list.where((n) => !n.isRead).length;
      });
    }
  }

  Widget homeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? badge,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mediumTeal.withOpacity(0.08), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.mediumTeal.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppColors.emeraldGlowGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, size: 28, color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.emeraldDeep,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                if (badge != null) Positioned(top: 0, right: 0, child: badge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('BUILD: AnaSayfa with locale: ${Localizations.localeOf(context)}');
    final String studentName = AuthService.userData?['name'] ?? '';
    
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.home,
          style: const TextStyle(
            color: AppColors.emeraldDeep,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.mediumTeal.withOpacity(0.1)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_active_outlined, color: AppColors.emeraldDeep),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BildirimlerSayfasi())).then((_) {
                        _loadUnreadNotifications();
                      });
                    },
                  ),
                  if (_unreadNotifications > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$_unreadNotifications',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 100), // Extra padding at bottom for floating bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcoming Area Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.emeraldGradient,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primaryGold.withOpacity(0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emeraldDeep.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            studentName.isNotEmpty ? studentName : 'Sevgili Öğrenci',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryGold, width: 2),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: const Icon(Icons.person, color: AppColors.primaryGold, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white.withOpacity(0.15), height: 1),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.progressTracking,
                        style: const TextStyle(
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        '%75 Tamamlandı',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 8,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Section Title
            const Text(
              'Menü İşlemleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.emeraldDeep,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            
            // Grid Operations
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                homeCard(
                  context: context,
                  icon: Icons.edit_note,
                  title: AppLocalizations.of(context)!.myAssignments,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const OdevlerimSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.menu_book,
                  title: AppLocalizations.of(context)!.lessons,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DerslerSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.folder_shared,
                  title: 'Ders Kaynakları',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const KaynaklarSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.notifications,
                  title: AppLocalizations.of(context)!.newNotification,
                  badge: _unreadNotifications > 0 ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                    child: Text('$_unreadNotifications', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ) : null,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BildirimlerSayfasi())).then((_) {
                      _loadUnreadNotifications();
                    });
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.analytics_outlined,
                  title: AppLocalizations.of(context)!.performanceReport,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DegerlendirmeSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.history_edu,
                  title: 'Değerlendirme Geçmişi',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DegerlendirmeGecmisiSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.calendar_month,
                  title: 'Gelecek Oturumlar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GelecekOturumlarSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.fact_check,
                  title: 'Yoklama (الحضور)',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const YoklamaSayfasi()));
                  },
                ),
                homeCard(
                  context: context,
                  icon: Icons.quiz,
                  title: 'Sınavlar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SinavlarSayfasi()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

