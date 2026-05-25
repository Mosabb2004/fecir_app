import 'package:flutter/material.dart';

/// El Fajr (Fecir) Tasarım Sistemi Renk Paleti (Emerald & Gold / Zümrüt & Altın)
/// 
/// Bu sınıf, uygulamanın premium, estetik ve profesyonel arayüz tasarımını kontrol eden
/// merkezi renk paletini ve degrade (gradient) tanımlamalarını barındırır.
class AppColors {
  // Geriye Dönük Uyumluluk (Legacy Mappings) için güncellenen anahtar renkler
  static const Color primaryGold = Color(0xFFD4AF37); // Lüks Altın Tonu
  static const Color petrolBlueDark = Color(0xFF003837); // Koyu Zümrüt Yeşili
  static const Color mediumTeal = Color(0xFF005B58); // Birincil Zümrüt Yeşili
  static const Color lightAqua = Color(0xFF83C5BE); // Yumuşak Adaçayı Yeşili
  static const Color darkGray = Color(0xFF5A6E6B); // Nötr Gri Slate
  static const Color veryLightGrayBackground = Color(0xFFF4F7F6); // Ultra Hafif Yumuşak Arka Plan

  // Premium Renk Katmanları (Modern Emerald & Gold Tasarım Sistemi)
  static const Color emeraldDeep = Color(0xFF002F2E);
  static const Color emeraldMain = Color(0xFF005B58);
  static const Color emeraldAccent = Color(0xFF008B86);
  static const Color sageLight = Color(0xFFE6F0EE);
  static const Color goldLuxury = Color(0xFFD4AF37);
  static const Color goldMetallic = Color(0xFFC5A03B);
  static const Color goldGlow = Color(0xFFFFF6D6);
  
  // Degrade (Gradient) Tasarımları - Arayüze Derinlik Kazandırmak İçin Tasarlanmıştır
  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [emeraldMain, emeraldDeep],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGlowGradient = LinearGradient(
    colors: [emeraldAccent, emeraldMain],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldLuxury, goldMetallic],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF7FAFA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}