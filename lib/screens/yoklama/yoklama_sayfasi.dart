import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../../models/attendance.dart';

class YoklamaSayfasi extends StatefulWidget {
  const YoklamaSayfasi({super.key});

  @override
  State<YoklamaSayfasi> createState() => _YoklamaSayfasiState();
}

class _YoklamaSayfasiState extends State<YoklamaSayfasi> {
  List<Attendance> _attendanceList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  Future<void> _loadAttendance() async {
    final list = await AuthService.getAttendance();
    if (mounted) {
      setState(() {
        _attendanceList = list;
        _isLoading = false;
      });
    }
  }

  Widget attendanceCard(Attendance attendance) {
    final bool isPresent = attendance.status.toLowerCase() == 'present' || attendance.status.toLowerCase() == 'حاضر';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: isPresent ? Colors.green : Colors.red, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isPresent ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPresent ? Icons.check_circle : Icons.cancel,
              color: isPresent ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tarih: ${attendance.date}', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 4),
                Text(
                  isPresent ? 'Katıldı (حاضر)' : 'Katılmadı (غائب)', 
                  style: TextStyle(
                    fontSize: 14, 
                    color: isPresent ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600
                  )
                ),
                if (attendance.notes != null && attendance.notes!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(attendance.notes!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ]
              ],
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
        title: const Text('Yoklama (الحضور)', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : _attendanceList.isEmpty 
          ? const Center(child: Text('Yoklama kaydı bulunamadı.'))
          : RefreshIndicator(
              onRefresh: _loadAttendance,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _attendanceList.length,
                itemBuilder: (context, index) {
                  return attendanceCard(_attendanceList[index]);
                },
              ),
            ),
    );
  }
}
