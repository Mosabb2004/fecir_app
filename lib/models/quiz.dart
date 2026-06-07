class Quiz {
  final int id;
  final String title;
  final String? description;
  final int durationMinutes;
  final List<dynamic> questions;

  Quiz({
    required this.id,
    required this.title,
    this.description,
    required this.durationMinutes,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? 'Sınav',
      description: json['description']?.toString(),
      durationMinutes: int.tryParse(json['duration_minutes']?.toString() ?? '30') ?? 30,
      questions: json['questions'] is List ? json['questions'] : [],
    );
  }
}
