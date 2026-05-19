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
        title: const Text('Duyurular', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.mediumTeal,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.grey, size: 60),
                    const SizedBox(height: 16),
                    const Text('Bağlantı sağlanamadı. Lütfen internetinizi kontrol edin.', textAlign: TextAlign.center),
                    TextButton(onPressed: () => setState(() => _newsFuture = _fetchNews()), child: const Text('Tekrar Dene'))
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Şu an yayınlanmış bir duyuru yok.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => _buildNewsCard(snapshot.data![index]),
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(NewsItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: () => _showDetail(item),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.image != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(item.image!, height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy').format(item.createdAt),
                    style: const TextStyle(color: AppColors.mediumTeal, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.petrolBlueDark)),
                  const SizedBox(height: 8),
                  Text(item.content.replaceAll(RegExp(r"<[^>]*>"), ""), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[600], height: 1.4)),
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
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.petrolBlueDark)),
                    const SizedBox(height: 8),
                    Text(DateFormat('dd MMMM yyyy').format(item.createdAt), style: const TextStyle(color: Colors.grey)),
                    const Divider(height: 32),
                    Text(item.content.replaceAll(RegExp(r"<[^>]*>"), ""), style: const TextStyle(fontSize: 16, height: 1.6, color: AppColors.petrolBlueDark)),
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
