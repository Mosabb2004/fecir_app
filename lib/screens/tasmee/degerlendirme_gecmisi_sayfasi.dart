import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../../models/recitation.dart';

class DegerlendirmeGecmisiSayfasi extends StatefulWidget {
  const DegerlendirmeGecmisiSayfasi({super.key});

  @override
  State<DegerlendirmeGecmisiSayfasi> createState() => _DegerlendirmeGecmisiSayfasiState();
}

class _DegerlendirmeGecmisiSayfasiState extends State<DegerlendirmeGecmisiSayfasi> {
  List<Recitation> _recitations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecitations();
  }

  Future<void> _loadRecitations() async {
    final list = await AuthService.getRecitations();
    if (mounted) {
      setState(() {
        _recitations = list;
        _isLoading = false;
      });
    }
  }

  Widget recitationCard(Recitation recitation) {
    // Generate some stars based on score
    final starCount = (recitation.score / 20).round().clamp(1, 5); // Assuming score is out of 100
    final starRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => Icon(
        index < starCount ? Icons.star : Icons.star_border,
        color: AppColors.primaryGold,
        size: 16,
      )),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: AppColors.mediumTeal, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(recitation.date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              starRow,
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.mediumTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Text('${recitation.score}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.mediumTeal)),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text('Okunan Sureler:', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: recitation.surahs.map((s) {
              final surahName = s['name'] ?? 'Sure';
              return Chip(
                label: Text(surahName.toString(), style: const TextStyle(color: AppColors.mediumTeal, fontSize: 12)),
                backgroundColor: AppColors.mediumTeal.withOpacity(0.1),
                side: BorderSide.none,
              );
            }).toList(),
          ),
          if (recitation.notes != null && recitation.notes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Text(recitation.notes!, style: TextStyle(color: Colors.grey.shade700, fontSize: 13, fontStyle: FontStyle.italic)),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Değerlendirme Geçmişi', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : _recitations.isEmpty 
          ? const Center(child: Text('Geçmiş değerlendirme kaydı bulunmuyor.'))
          : RefreshIndicator(
              onRefresh: _loadRecitations,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _recitations.length,
                itemBuilder: (context, index) {
                  return recitationCard(_recitations[index]);
                },
              ),
            ),
    );
  }
}
