import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../../models/next_recitation.dart';

class GelecekOturumlarSayfasi extends StatefulWidget {
  const GelecekOturumlarSayfasi({super.key});

  @override
  State<GelecekOturumlarSayfasi> createState() => _GelecekOturumlarSayfasiState();
}

class _GelecekOturumlarSayfasiState extends State<GelecekOturumlarSayfasi> {
  List<NextRecitation> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final list = await AuthService.getNextRecitations();
    if (mounted) {
      setState(() {
        _sessions = list;
        _isLoading = false;
      });
    }
  }

  Widget sessionCard(NextRecitation session) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: const Border(left: BorderSide(color: AppColors.primaryGold, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month, color: AppColors.primaryGold, size: 20),
              const SizedBox(width: 8),
              Text(session.date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              if (session.time != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryGold.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                  child: Text(session.time!, style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Planlanan Sureler:', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: session.surahs.map((s) {
              final surahName = s['name'] ?? 'Sure';
              return Chip(
                label: Text(surahName.toString(), style: const TextStyle(color: AppColors.mediumTeal, fontSize: 12)),
                backgroundColor: AppColors.mediumTeal.withOpacity(0.1),
                side: BorderSide.none,
              );
            }).toList(),
          ),
          if (session.notes != null && session.notes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Text(session.notes!, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
            )
          ]
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
        title: const Text('Gelecek Oturumlar', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : _sessions.isEmpty 
          ? const Center(child: Text('Planlanmış gelecek oturumunuz bulunmuyor.'))
          : RefreshIndicator(
              onRefresh: _loadSessions,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  return sessionCard(_sessions[index]);
                },
              ),
            ),
    );
  }
}
