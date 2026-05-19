class ResourceFile {
  final int id;
  final String name;
  final String? url;
  final String? extension;

  ResourceFile({
    required this.id,
    required this.name,
    this.url,
    this.extension,
  });

  factory ResourceFile.fromJson(Map<String, dynamic> json) {
    // Sunucudan gelen kesin isimler: 'link' veya 'file_url'
    String? detectedUrl = json['link'] ?? json['file_url'] ?? json['file'] ?? json['url'];
    
    return ResourceFile(
      id: json['id'] ?? 0,
      name: json['name'] ?? json['title'] ?? 'İsimsiz Dosya',
      url: detectedUrl,
      extension: json['extension'] ?? (detectedUrl != null ? detectedUrl.split('.').last : 'pdf'),
    );
  }
}
