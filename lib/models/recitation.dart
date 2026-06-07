class Recitation {
  final int id;
  final String date;
  final double score;
  final String? notes;
  final List<dynamic> surahs;

  Recitation({
    required this.id,
    required this.date,
    required this.score,
    this.notes,
    required this.surahs,
  });

  factory Recitation.fromJson(Map<String, dynamic> json) {
    return Recitation(
      id: json['id'] ?? 0,
      date: json['date']?.toString() ?? '',
      score: double.tryParse(json['score']?.toString() ?? '0.0') ?? 0.0,
      notes: json['notes']?.toString(),
      surahs: json['surahs'] is List ? json['surahs'] : [],
    );
  }
}
