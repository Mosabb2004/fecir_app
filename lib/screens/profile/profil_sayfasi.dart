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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(AppLocalizations.of(context)!.logout),
          content: Text(AppLocalizations.of(context)!.logoutConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                AuthService.userToken = null; 
                AuthService.userData = null;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const GirisSayfasi()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(AppLocalizations.of(context)!.logout, style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.userData;
    
    // Sunucudan gelen kesin anahtarları kullanıyoruz
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
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.profile, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.lightAqua.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.mediumTeal, width: 2),
                    ),
                    child: const Icon(Icons.person, size: 60, color: AppColors.mediumTeal),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.petrolBlueDark),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
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
            ),
            
            const SizedBox(height: 30),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuItem(Icons.settings_outlined, AppLocalizations.of(context)!.settings, () {}),
                  _buildMenuItem(Icons.help_outline_outlined, AppLocalizations.of(context)!.helpSupport, () {}),
                  _buildMenuItem(Icons.info_outline, AppLocalizations.of(context)!.aboutUs, () {}),
                  const SizedBox(height: 10),
                  _buildMenuItem(Icons.logout, AppLocalizations.of(context)!.logout, _showLogoutDialog, isLogout: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
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
              color: AppColors.lightAqua.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.mediumTeal, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.petrolBlueDark), overflow: TextOverflow.visible),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey.withOpacity(0.1), indent: 50);
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.redAccent : AppColors.mediumTeal),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.redAccent : AppColors.petrolBlueDark,
            fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: onTap,
      ),
    );
  }
}
