import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../quiz/sinav_sayfasi.dart';
import '../../services/auth_service.dart';
import '../../models/homework.dart';

class OdevlerimSayfasi extends StatefulWidget {
  const OdevlerimSayfasi({super.key});

  @override
  State<OdevlerimSayfasi> createState() => _OdevlerimSayfasiState();
}

class _OdevlerimSayfasiState extends State<OdevlerimSayfasi> {
  List<Homework> _homeworks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHomeworks();
  }

  Future<void> _loadHomeworks() async {
    final list = await AuthService.getHomeworks();
    if (mounted) {
      setState(() {
        _homeworks = list;
        _isLoading = false;
      });
    }
  }

  Widget assignmentCard({
    required BuildContext context,
    required Homework homework,
  }) {
    final completed = homework.isCompleted;
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
              color: completed ? Colors.green.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(completed ? Icons.check : Icons.hourglass_bottom, color: completed ? Colors.green : Colors.orange),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(homework.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                if (homework.dueDate != null) 
                  Text('Son Tarih: ${homework.dueDate}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(completed ? 'Tamamlandı' : 'Tamamlanmadı', style: TextStyle(color: completed ? Colors.green : Colors.orange, fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mediumTeal,
              minimumSize: Size.zero, // Fix: Override double.infinity from theme
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => SinavSayfasi(dersAdi: homework.title))
              );
            },
            child: Text(completed ? 'Görüntüle' : 'Çöz', style: const TextStyle(color: Colors.white)),
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
        title: const Text('Ödevlerim', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : _homeworks.isEmpty 
          ? const Center(child: Text('Henüz atanmış bir ödeviniz bulunmuyor.'))
          : RefreshIndicator(
              onRefresh: _loadHomeworks,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _homeworks.length,
                itemBuilder: (context, index) {
                  return assignmentCard(context: context, homework: _homeworks[index]);
                },
              ),
            ),
    );
  }
}
