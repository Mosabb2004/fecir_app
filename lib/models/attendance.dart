class Attendance {
  final int id;
  final String date;
  final String status;
  final String? notes;

  Attendance({
    required this.id,
    required this.date,
    required this.status,
    this.notes,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] ?? 0,
      date: json['date']?.toString() ?? '',
      status: json['status']?.toString() ?? 'present',
      notes: json['notes']?.toString(),
    );
  }
}
