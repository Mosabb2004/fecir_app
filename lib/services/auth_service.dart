import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/homework.dart';
import '../models/video_lesson.dart';
import '../models/resource_file.dart';
import '../models/recitation.dart';
import '../models/next_recitation.dart';
import '../models/attendance.dart';
import '../models/quiz.dart';
import '../models/notification_model.dart';

/// El Fajr (Fecir) Kimlik Doğrulama ve Veri Servisi (API Service)
/// 
/// Bu servis, uygulamanın uzak sunucuyla (API REST) olan tüm veri alışverişini yönetir.
/// Bearer Token tabanlı kimlik doğrulama mekanizmasını implemente eder.
class AuthService {
  static String? userToken;
  static Map<String, dynamic>? userData;
  
  static const String baseUrl = 'https://alfajr.tech/api';
  static String? lastError;

  /// Kullanıcı Giriş (Login) İşlemi
  /// E-posta ve şifre alarak sunucuya POST isteği gönderir ve Bearer Token döndürür.
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
          userData = data['user']; // Kullanıcı oturum bilgilerini sakla
          return true;
        } else {
          lastError = "Hatalı Yanıt: Sunucudan beklenen veri şeması alınamadı.";
          return false;
        }
      } else {
        lastError = "Hata: ${response.statusCode} - Giriş başarısız.";
        return false;
      }
    } catch (e) {
      lastError = "Bağlantı Hatası: Lütfen internetinizi kontrol edin.";
      return false;
    }
  }

  /// Profil Verilerini Güncelleme İstetiği
  static Future<bool> getUserProfile() async {
    if (userToken == null) return false;
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userData = data is Map && data.containsKey('data') ? data['data'] : data;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('EL FAJR (HATA): Profil çekilemedi: $e');
      return false;
    }
  }

  /// Ödev Listesini Uzak Sunucudan Çeker
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
      debugPrint('EL FAJR (HATA): Ödevler çekilemedi: $e');
      return [];
    }
  }

  /// Video Ders İçeriklerini Uzak Sunucudan Çeker
  static Future<List<VideoLesson>> getVideos() async {
    if (userToken == null) return [];
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/videos'),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') 
            ? jsonData['data'] 
            : (jsonData is List ? jsonData : []);
            
        return list.map((item) => VideoLesson.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('EL FAJR (HATA): Videolar çekilemedi: $e');
      return [];
    }
  }

  /// Eğitim Kaynak Dosyalarını Uzak Sunucudan Çeker
  static Future<List<ResourceFile>> getFiles() async {
    if (userToken == null) return [];
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/files'),
        headers: getAuthHeaders(),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') 
            ? jsonData['data'] 
            : (jsonData is List ? jsonData : []);
            
        return list.map((item) => ResourceFile.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('EL FAJR (HATA): Dosyalar çekilemedi: $e');
      return [];
    }
  }

  static Future<List<Recitation>> getRecitations() async {
    if (userToken == null) return [];
    try {
      final response = await http.get(Uri.parse('$baseUrl/recitations'), headers: getAuthHeaders()).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') ? jsonData['data'] : (jsonData is List ? jsonData : []);
        return list.map((item) => Recitation.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('EL FAJR (HATA): Recitations failed: $e');
      return [];
    }
  }

  static Future<List<NextRecitation>> getNextRecitations() async {
    if (userToken == null) return [];
    try {
      final response = await http.get(Uri.parse('$baseUrl/next-recitations'), headers: getAuthHeaders()).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') ? jsonData['data'] : (jsonData is List ? jsonData : []);
        return list.map((item) => NextRecitation.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('EL FAJR (HATA): NextRecitations failed: $e');
      return [];
    }
  }

  static Future<List<Attendance>> getAttendance() async {
    if (userToken == null) return [];
    try {
      final response = await http.get(Uri.parse('$baseUrl/attendance'), headers: getAuthHeaders()).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') ? jsonData['data'] : (jsonData is List ? jsonData : []);
        return list.map((item) => Attendance.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('EL FAJR (HATA): Attendance failed: $e');
      return [];
    }
  }

  static Future<List<Quiz>> getQuizzes() async {
    if (userToken == null) return [];
    try {
      final response = await http.get(Uri.parse('$baseUrl/quizzes'), headers: getAuthHeaders()).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is Map && jsonData.containsKey('data') ? jsonData['data'] : (jsonData is List ? jsonData : []);
        return list.map((item) => Quiz.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('EL FAJR (HATA): Quizzes failed: $e');
      return [];
    }
  }

  static Future<List<NotificationModel>> getNotifications() async {
    if (userToken == null) return [];
    try {
      final response = await http.get(Uri.parse('$baseUrl/notifications'), headers: getAuthHeaders()).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final List<dynamic> list = jsonData is List ? jsonData : (jsonData is Map && jsonData.containsKey('data') ? jsonData['data'] : []);
        return list.map((item) => NotificationModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('EL FAJR (HATA): Notifications failed: $e');
      return [];
    }
  }

  static Future<bool> markNotificationsRead() async {
    if (userToken == null) return false;
    try {
      final response = await http.post(Uri.parse('$baseUrl/notifications/mark-read'), headers: getAuthHeaders()).timeout(const Duration(seconds: 15));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('EL FAJR (HATA): markNotificationsRead failed: $e');
      return false;
    }
  }

  /// Yetkilendirilmiş İstekler (Authenticated Requests) için HTTP Header Bilgisini Döner
  static Map<String, String> getAuthHeaders() {
    return {
      'Authorization': 'Bearer $userToken',
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': '1', // ngrok uyarı ekranını aşmak için gerekli bypass header'ı
    };
  }
}
