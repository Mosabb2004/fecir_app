import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/generated/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'screens/giris/giris_sayfasi.dart';

/// El Fajr (Fecir) Eğitim Platformu Giriş Noktası
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Çoklu dil desteği (Türkçe & Arapça) için reaktif durum yöneticisi (State Manager)
  /// Reaktif yapı sayesinde dil değişimi tüm arayüzde anlık olarak güncellenir.
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('tr'));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, currentLocale, child) {
        debugPrint('EL FAJR: Uygulama dili güncellendi: $currentLocale');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'El Fajr Eğitim Platformu',
          
          // Çoklu Dil Desteği Delegeleri (Localization)
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          
          // Desteklenen Diller
          supportedLocales: const [
            Locale('tr'), // Türkçe
            Locale('ar'), // Arapça
          ],
          
          locale: currentLocale,
          
          // Merkezi Tasarım Sistemi (Emerald & Gold Premium Arayüzü)
          theme: AppTheme.light,
          
          // Başlangıç Sayfası (Giriş Ekranı)
          home: const GirisSayfasi(),
        );
      },
    );
  }
}
