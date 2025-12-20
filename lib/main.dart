import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'screens/login/login_page.dart';


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

        // ===== COLOR SCHEME (DOĞRU YOL) =====
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.mediumTeal,
          onPrimary: Colors.white,
          secondary: AppColors.primaryGold,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: AppColors.veryLightGrayBackground,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),

        // ===== APP BAR =====
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mediumTeal,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),

        // ===== INPUTS =====
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.mediumTeal,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.petrolBlueDark,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),

      home: const LoginPage(),
    );
  }
}
