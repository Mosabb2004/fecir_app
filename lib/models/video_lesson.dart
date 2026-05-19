class VideoLesson {
  final int id;
  final String title;
  final String? topic;
  final String? videoUrl;
  final String? teacherName;
  final String? thumbnailUrl;
  final String? duration;

  VideoLesson({
    required this.id,
    required this.title,
    this.topic,
    this.videoUrl,
    this.teacherName,
    this.thumbnailUrl,
    this.duration,
  });

  factory VideoLesson.fromJson(Map<String, dynamic> json) {
    // Sunucudan gelen videolarda genellikle 'link' anahtarı kullanılıyor
    String? detectedUrl = json['link'] ?? json['video_url'] ?? json['url'] ?? json['video_link'];
    
    return VideoLesson(
      id: json['id'] ?? 0,
      title: json['name'] ?? json['title'] ?? json['subject_name'] ?? 'İsimsiz Ders',
      topic: json['description'] ?? json['topic'] ?? '',
      videoUrl: detectedUrl,
      teacherName: json['instructor'] ?? json['teacher_name'] ?? json['teacher'] ?? 'Eğitmen',
      thumbnailUrl: json['image'] ?? json['thumbnail_url'] ?? json['thumb'],
      duration: json['duration'],
    );
  }
}
