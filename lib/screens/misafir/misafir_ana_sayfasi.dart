import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';
import '../../models/news_item.dart';
import '../giris/giris_sayfasi.dart';

class MisafirAnaSayfasi extends StatefulWidget {
  const MisafirAnaSayfasi({super.key});

  @override
  State<MisafirAnaSayfasi> createState() => _MisafirAnaSayfasiState();
}

class _MisafirAnaSayfasiState extends State<MisafirAnaSayfasi> {
  late Future<List<NewsItem>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchNews();
  }

  Future<List<NewsItem>> _fetchNews() async {
    final response = await http.get(
      Uri.parse('https://dust-visitor-essence.ngrok-free.dev/api/news'),
      headers: {'ngrok-skip-browser-warning': '1'},
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => NewsItem.fromJson(data)).toList();
    } else {
      throw Exception('Duyurular yüklenemedi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.veryLightGrayBackground,
      appBar: AppBar(
        title: const Text(
          'Duyurular',
          style: TextStyle(
            color: AppColors.emeraldDeep,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: FutureBuilder<List<NewsItem>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.mediumTeal));
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.wifi_off_rounded, color: Colors.redAccent, size: 50),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bağlantı Sağlanamadı',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lütfen internet bağlantınızı kontrol edip tekrar deneyin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.darkGray),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => setState(() => _newsFuture = _fetchNews()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mediumTeal,
                        minimumSize: const Size(150, 44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Tekrar Dene', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Şu an yayınlanmış bir duyuru yok.',
                style: TextStyle(color: AppColors.darkGray, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => _buildNewsCard(snapshot.data![index]),
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(NewsItem item) {
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
      child: InkWell(
        onTap: () => _showDetail(item),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.image != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  item.image!,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.sageLight,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.mediumTeal.withOpacity(0.1)),
                    ),
                    child: Text(
                      DateFormat('dd.MM.yyyy').format(item.createdAt),
                      style: const TextStyle(
                        color: AppColors.mediumTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.emeraldDeep,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.content.replaceAll(RegExp(r"<[^>]*>"), ""),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.darkGray,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetail(NewsItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 46,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Detail Header banner if image exists
            if (item.image != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(item.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Date Pill
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.primaryGold),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd MMMM yyyy').format(item.createdAt),
                          style: const TextStyle(
                            color: AppColors.darkGray,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.emeraldDeep,
                        height: 1.3,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    const Divider(color: Color(0x2B005B58), thickness: 1.2),
                    const SizedBox(height: 16),
                    
                    Text(
                      item.content.replaceAll(RegExp(r"<[^>]*>"), ""),
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.7,
                        color: AppColors.emeraldDeep,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
