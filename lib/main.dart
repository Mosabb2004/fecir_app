import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'screens/giris/giris_sayfasi.dart'; // Mevcut olan dosya

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El Fajr',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.veryLightGrayBackground,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.mediumTeal,
          onPrimary: Colors.white,
          secondary: AppColors.primaryGold,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mediumTeal,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
      home: const GirisSayfasi(), // Mevcut olan sınıf
    );
  }
}
