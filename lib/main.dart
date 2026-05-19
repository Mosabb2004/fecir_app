import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/generated/app_localizations.dart';
import 'constants/app_colors.dart';
import 'screens/giris/giris_sayfasi.dart'; // Mevcut olan dosya

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Dil değişimi için global bir notifier
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('tr'));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, currentLocale, child) {
        debugPrint('BUILD: MyApp with locale: $currentLocale');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Innovation System',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('tr'), // Türkçe
            Locale('ar'), // Arapça
          ],
          locale: currentLocale,
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
      },
    );
  }
}
