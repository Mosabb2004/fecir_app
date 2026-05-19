class Homework {
  final int id;
  final String title;
  final String? description;
  final String? dueDate;
  final bool isCompleted;

  Homework({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.isCompleted = false,
  });

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['subject'] ?? 'İsimsiz Ödev',
      description: json['description'],
      dueDate: json['due_date'] ?? json['deadline'],
      isCompleted: json['completed'] == true || json['status'] == 'completed' || json['status'] == 1,
    );
  }
}
