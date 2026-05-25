import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// El Fajr (Fecir) Tasarım Sistemi (Arayüz Teması)
/// 
/// Bu sınıf, uygulamanın genel görsel kimliğini ve tasarım dilini belirler.
/// Flutter'ın yerel ThemeData API'si kullanılarak, Material 3 standartlarında,
/// projenin Zümrüt Yeşili & Altın konseptine (Option A) uygun olarak özelleştirilmiştir.
class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.veryLightGrayBackground,
    primaryColor: AppColors.mediumTeal,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mediumTeal,
      primary: AppColors.mediumTeal,
      secondary: AppColors.primaryGold,
      surface: Colors.white,
      background: AppColors.veryLightGrayBackground,
    ),
    
    // Tipografi Yapılandırması (Gelişmiş Harf Aralığı ve Arayüz Satır Yükseklikleri)
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Roboto', letterSpacing: -0.5, fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
      headlineMedium: TextStyle(fontFamily: 'Roboto', letterSpacing: 0.1, fontWeight: FontWeight.bold, color: AppColors.emeraldDeep),
      titleLarge: TextStyle(fontFamily: 'Roboto', letterSpacing: 0.15, fontWeight: FontWeight.w600, color: AppColors.emeraldDeep),
      bodyLarge: TextStyle(fontFamily: 'Roboto', letterSpacing: 0.5, height: 1.4, color: AppColors.emeraldDeep),
      bodyMedium: TextStyle(fontFamily: 'Roboto', letterSpacing: 0.25, height: 1.4, color: AppColors.darkGray),
    ),

    // Kart Tasarımı (Ultra İnce Zümrüt Çerçeve Detayı & Sıfır Gölgeli Temiz Kart Yapısı)
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x1A005B58), width: 1), // İnce şeffaf zümrüt kenarlık
      ),
    ),

    // Form Elemanları (Giriş Kutuları / Input Decoration Theme)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      labelStyle: const TextStyle(color: AppColors.mediumTeal, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0x2B005B58), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0x2B005B58), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.mediumTeal, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    ),

    // Buton Teması (Premium Buton Tasarımı - Yüksek Dokunmatik Alan Standardı)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.mediumTeal,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Üst Bar Tasarımı (Transparent AppBar Theme)
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.emeraldDeep),
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        color: AppColors.emeraldDeep,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

