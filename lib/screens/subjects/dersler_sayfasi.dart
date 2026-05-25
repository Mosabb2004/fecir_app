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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mediumTeal.withOpacity(0.08), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.emeraldDeep.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (video.topic != null && video.topic!.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.sageLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            video.topic!,
                            style: const TextStyle(
                              color: AppColors.mediumTeal,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Text(
                        video.title,
                        style: const TextStyle(
                          color: AppColors.emeraldDeep,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: AppColors.primaryGold),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              video.teacherName ?? 'Fecr Eğitim',
                              style: const TextStyle(color: AppColors.darkGray, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryGold.withOpacity(0.2), width: 1.2),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: video.thumbnailUrl != null && video.thumbnailUrl!.isNotEmpty
                          ? Image.network(
                              video.thumbnailUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: AppColors.sageLight,
                                child: const Icon(Icons.video_library, color: AppColors.mediumTeal),
                              ),
                            )
                          : Container(
                              color: AppColors.sageLight,
                              child: const Icon(Icons.video_library, color: AppColors.mediumTeal),
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGold.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.lessons,
          style: const TextStyle(
            color: AppColors.emeraldDeep,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.mediumTeal.withOpacity(0.1)),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.emeraldDeep, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
        : RefreshIndicator(
            onRefresh: _loadVideos,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              itemCount: _videos.length,
              itemBuilder: (context, index) => videoCard(context: context, video: _videos[index]),
            ),
          ),
    );
  }
}

