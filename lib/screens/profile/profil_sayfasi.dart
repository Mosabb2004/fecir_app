import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';
import '../giris/giris_sayfasi.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../services/auth_service.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({super.key});

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    await AuthService.getUserProfile();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 24),
              ),
              const SizedBox(width: 14),
              Text(
                AppLocalizations.of(context)!.logout,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
              ),
            ],
          ),
          content: Text(
            AppLocalizations.of(context)!.logoutConfirm,
            style: const TextStyle(color: AppColors.darkGray, fontSize: 15, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  elevation: 0,
                  minimumSize: const Size(100, 42),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  AuthService.userToken = null; 
                  AuthService.userData = null;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const GirisSayfasi()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.logout,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.userData;
    
    String name = user?['name']?.toString() ?? 'Öğrenci';
    String email = user?['email']?.toString() ?? '---';
    String phone = user?['phone']?.toString() ?? 'Belirtilmemiş';
    String address = user?['address']?.toString() ?? 'Adres Bilgisi Yok';
    String id = user?['id']?.toString() ?? '---';
    String createdAt = user?['created_at']?.toString() ?? '';

    String formattedDate = 'Bilgi Yok';
    if (createdAt.isNotEmpty) {
      try {
        DateTime dt = DateTime.parse(createdAt);
        formattedDate = DateFormat('dd MMMM yyyy').format(dt);
      } catch (e) {
        formattedDate = createdAt.split(' ' )[0];
      }
    }
    
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: const TextStyle(
            color: AppColors.emeraldDeep,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120), // Padding to avoid navigation bar clash
        child: Column(
          children: [
            // Luxurious Profile Header Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.emeraldGradient,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primaryGold.withOpacity(0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emeraldDeep.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryGold, width: 2.5),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
                      ],
                    ),
                    child: const Icon(Icons.person, size: 54, color: AppColors.primaryGold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            
            // Student Information Fields Panel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 10, right: 8.0),
                    child: Text(
                      'Öğrenci Bilgileri',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.mediumTeal.withOpacity(0.08), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: AppColors.mediumTeal.withOpacity(0.03), blurRadius: 16, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.person_outline, "Öğrenci ID", "#$id"),
                        _buildDivider(),
                        _buildInfoRow(Icons.email_outlined, "E-posta", email),
                        _buildDivider(),
                        _buildInfoRow(Icons.phone_android_outlined, "Telefon", phone),
                        _buildDivider(),
                        _buildInfoRow(Icons.location_on_outlined, "Adres", address),
                        _buildDivider(),
                        _buildInfoRow(Icons.calendar_today_outlined, "Kayıt Tarihi", formattedDate),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Settings Menu Items Panel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 10, right: 8.0),
                    child: Text(
                      'Hesap Ayarları',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
                    ),
                  ),
                  Column(
                    children: [
                      _buildMenuItem(Icons.settings_outlined, AppLocalizations.of(context)!.settings, () {}),
                      _buildMenuItem(Icons.help_outline_outlined, AppLocalizations.of(context)!.helpSupport, () {}),
                      _buildMenuItem(Icons.info_outline, AppLocalizations.of(context)!.aboutUs, () {}),
                      const SizedBox(height: 6),
                      _buildMenuItem(Icons.logout, AppLocalizations.of(context)!.logout, _showLogoutDialog, isLogout: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.sageLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.mediumTeal.withOpacity(0.08)),
            ),
            child: Icon(icon, color: AppColors.mediumTeal, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: AppColors.mediumTeal.withOpacity(0.06), indent: 50);
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isLogout 
              ? Colors.redAccent.withOpacity(0.1) 
              : AppColors.mediumTeal.withOpacity(0.06),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isLogout 
                ? Colors.redAccent.withOpacity(0.01) 
                : AppColors.mediumTeal.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout ? Colors.redAccent.withOpacity(0.08) : AppColors.sageLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: isLogout ? Colors.redAccent : AppColors.mediumTeal, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.redAccent : AppColors.emeraldDeep,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: isLogout ? Colors.redAccent.withOpacity(0.5) : Colors.grey[400],
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}
