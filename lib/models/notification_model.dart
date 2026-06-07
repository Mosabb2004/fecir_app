class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String body;
  final String? icon;
  final String? color;
  final String? readAt;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.icon,
    this.color,
    this.readAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: data['title']?.toString() ?? 'Bildirim',
      body: data['body']?.toString() ?? '',
      icon: data['icon']?.toString(),
      color: data['color']?.toString(),
      readAt: json['read_at']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
    );
  }

  bool get isRead => readAt != null;
}
