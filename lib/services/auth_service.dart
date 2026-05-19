import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/homework.dart';
import '../models/video_lesson.dart';
import '../models/resource_file.dart';

class AuthService {
  static String? userToken;
  static Map<String, dynamic>? userData;
  static const String baseUrl = 'https://dust-visitor-essence.ngrok-free.dev/api';

  static String? lastError;

  static Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;
    lastError = null;
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': '1',
        },
        body: json.encode({
          'username': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['token'] != null && data['user'] != null) {
          userToken = data['token'];
          userData = data['user']; // Kullanıcı bilgilerini saklıyoruz
          return true;
        } else {
          lastError = "Hatalı Yanıt: Token veya Kullanıcı bulunamadı.";
          return false;
        }
      } else {
        lastError = "Hata: ${response.statusCode}\n${response.body}";
        return false;
      }
    } catch (e) {
      lastError = "Bağlantı Hatası: $e";
      return false;
    }
  }

  // Kullanıcı detaylarını çeken yeni metod
  static Future<bool> getUserProfile() async {
    if (userToken == null) return false;
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));

      print('USER PROFILE RAW: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Eğer veri "data" anahtarı altındaysa onu al, yoksa direkt veriyi al
        userData = data is Map && data.containsKey('data') ? data['data'] : data;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Profil çekme hatası: $e');
      return false;
    }
  }

  // Ödevleri çeken metod
  static Future<List<Homework>> getHomeworks() async {
    if (userToken == null) return [];
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeworks'),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') 
            ? jsonData['data'] 
            : (jsonData is List ? jsonData : []);
            
        return list.map((item) => Homework.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Ödev çekme hatası: $e');
      return [];
    }
  }

  // Videoları çeken metod
  static Future<List<VideoLesson>> getVideos() async {
    print('>>> GET VIDEOS CALLED. TOKEN STATUS: ${userToken != null}');
    if (userToken == null) {
      print('>>> HATA: TOKEN BULUNAMADI! VIDEOLAR CEKILEMIYOR.');
      return [];
    }
    
    try {
      final url = '$baseUrl/videos';
      print('>>> VIDEO ISTEGI GONDERILIYOR: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));

      print('################### RAW VIDEOS START ###################');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('################### RAW VIDEOS END ###################');
      
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') 
            ? jsonData['data'] 
            : (jsonData is List ? jsonData : []);
            
        print('>>> PARSED VIDEO COUNT: ${list.length}');
        return list.map((item) => VideoLesson.fromJson(item)).toList();
      } else {
        print('>>> SUNUCU HATASI (VIDEOS): ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('>>> VIDEO CEKME HATASI (CRITICAL): $e');
      return [];
    }
  }

  // Dosyaları/Kaynakları çeken metod
  static Future<List<ResourceFile>> getFiles() async {
    if (userToken == null) return [];
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/files'),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));

      print('################### RAW FILES START ###################');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      print('################### RAW FILES END ###################');

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') 
            ? jsonData['data'] 
            : (jsonData is List ? jsonData : []);
            
        return list.map((item) => ResourceFile.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('>>> DOSYA CEKME HATASI: $e');
      return [];
    }
  }

  // Header hazırlayan yardımcı fonksiyon
  static Map<String, String> getAuthHeaders() {
    return {
      'Authorization': 'Bearer $userToken',
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': '1',
    };
  }
}
