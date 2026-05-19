import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../services/auth_service.dart';
import '../../models/video_lesson.dart';
import 'ders_detay_sayfasi.dart';

class DerslerSayfasi extends StatefulWidget {
  const DerslerSayfasi({super.key});

  @override
  State<DerslerSayfasi> createState() => _DerslerSayfasiState();
}

class _DerslerSayfasiState extends State<DerslerSayfasi> {
  List<VideoLesson> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() => _isLoading = true);
    try {
      final list = await AuthService.getVideos();
      if (mounted) {
        setState(() {
          _videos = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget videoCard({
    required BuildContext context,
    required VideoLesson video,
  }) {
    return InkWell(
      onTap: () {
        print('PLAYING VIDEO URL: ${video.videoUrl}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DersDetaySayfasi(
              subjectName: video.title,
              lessonNumber: video.duration ?? 'Ders Videosu',
              topic: video.topic ?? '',
              teacherName: video.teacherName ?? 'Eğitmen',
              imagePath: video.thumbnailUrl ?? '',
              videoUrl: video.videoUrl,
              isUrl: true,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.petrolBlueDark,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      video.teacherName ?? 'Fecr Eğitim',
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                  child: video.thumbnailUrl != null && video.thumbnailUrl!.isNotEmpty
                    ? Image.network(
                        video.thumbnailUrl!,
                        width: 140,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(width: 140, color: Colors.grey[200], child: const Icon(Icons.video_library)),
                      )
                    : Container(width: 140, color: Colors.grey[200], child: const Icon(Icons.video_library)),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), shape: BoxShape.circle),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.lessons, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : RefreshIndicator(
            onRefresh: _loadVideos,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _videos.length,
              itemBuilder: (context, index) => videoCard(context: context, video: _videos[index]),
            ),
          ),
    );
  }
}
