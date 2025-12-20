import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.veryLightGrayBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mediumTeal,
      primary: AppColors.mediumTeal,
      secondary: AppColors.primaryGold,
    ),
  );
}
