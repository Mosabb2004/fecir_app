class NextRecitation {
  final int id;
  final String date;
  final String? time;
  final String? notes;
  final List<dynamic> surahs;

  NextRecitation({
    required this.id,
    required this.date,
    this.time,
    this.notes,
    required this.surahs,
  });

  factory NextRecitation.fromJson(Map<String, dynamic> json) {
    return NextRecitation(
      id: json['id'] ?? 0,
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString(),
      notes: json['notes']?.toString(),
      surahs: json['surahs'] is List ? json['surahs'] : [],
    );
  }
}
