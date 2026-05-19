import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';

class VideoOynaticiSayfasi extends StatelessWidget {
  final String videoUrl;
  final String title;

  const VideoOynaticiSayfasi({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(videoUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Web'de ise doğrudan yönlendirme yapıyoruz (Hata almamak için en güvenli yol)
    if (kIsWeb) {
      // Sayfa açılır açılmaz videoyu yeni sekmede başlatıyoruz
      Future.delayed(Duration.zero, () => _launchURL());

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(title, style: const TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.open_in_new, color: Colors.white, size: 50),
              const SizedBox(height: 20),
              const Text(
                'Video yeni sekmede açılıyor...',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _launchURL,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mediumTeal),
                child: const Text('Tekrar Aç', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    // Mobil versiyon için buraya daha sonra standart oynatıcı dönebilir
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(child: Text('Mobil oynatıcı hazırlık aşamasında...', style: TextStyle(color: Colors.white))),
    );
  }
}
