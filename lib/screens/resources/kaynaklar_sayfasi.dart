import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../../models/resource_file.dart';

class KaynaklarSayfasi extends StatefulWidget {
  const KaynaklarSayfasi({super.key});

  @override
  State<KaynaklarSayfasi> createState() => _KaynaklarSayfasiState();
}

class _KaynaklarSayfasiState extends State<KaynaklarSayfasi> {
  List<ResourceFile> _files = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    setState(() => _isLoading = true);
    final list = await AuthService.getFiles();
    if (mounted) {
      setState(() {
        _files = list;
        _isLoading = false;
      });
    }
  }

  // Garantili indirme/açma metodu
  void _downloadFile(String? url) {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hata: Dosya linki bulunamadı.')),
      );
      return;
    }

    print('>>> DOSYA INDIRILIYOR: $url');

    if (kIsWeb) {
      // Chrome'da en güvenli yol: Yeni pencerede açmak
      // Bu sayede tarayıcı dosyayı algılar ve indirmeyi başlatır.
      html.window.open(url, '_blank');
    } else {
      _launchInBrowser(url);
    }
  }

  Future<void> _launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarayıcı açılamadı.')),
        );
      }
    }
  }

  IconData _getFileIcon(String? ext) {
    switch (ext?.toLowerCase()) {
      case 'pdf': return Icons.picture_as_pdf;
      case 'doc':
      case 'docx': return Icons.description;
      case 'xls':
      case 'xlsx': return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png': return Icons.image;
      default: return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mediumTeal,
        title: const Text('Ders Kaynakları', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal))
          : RefreshIndicator(
              onRefresh: _loadFiles,
              child: _files.isEmpty
                  ? const Center(child: Text('Henüz yüklü dosya bulunmuyor.'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final file = _files[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.mediumTeal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(_getFileIcon(file.extension), color: AppColors.mediumTeal),
                            ),
                            title: Text(file.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            subtitle: Text('${file.extension?.toUpperCase() ?? 'DOSYA'}'),
                            trailing: Container(
                              decoration: BoxDecoration(
                                color: AppColors.mediumTeal,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.file_download, color: Colors.white, size: 20),
                                onPressed: () => _downloadFile(file.url),
                              ),
                            ),
                            onTap: () => _downloadFile(file.url),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
