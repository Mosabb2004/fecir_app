class NewsItem {
  final int id;
  final String title;
  final String content;
  final String? image;
  final DateTime createdAt;

  NewsItem({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.createdAt,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: _stripHtml(json['title'] ?? ''),
      content: json['content'] ?? '',
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  static String _stripHtml(String htmlString) {
    // Basic regex to strip HTML tags
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').replaceAll('&nbsp;', ' ').trim();
  }
}
