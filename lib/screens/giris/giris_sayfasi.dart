import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../ana_ekran/ana_ekran_sayfasi.dart'; // Mevcut dosya
import '../misafir/misafir_ana_sayfasi.dart'; // Mevcut dosya

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AnaEkranSayfasi(), // Mevcut sınıf
        ),
      );
    }
  }

  void _loginAsGuest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MisafirAnaSayfasi(), // Mevcut sınıf
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightAqua.withOpacity(0.2),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/shape.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'E-posta',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lütfen e-posta adresinizi girin';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              textAlign: TextAlign.left,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Şifre',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lütfen şifrenizi girin';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mediumTeal,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Giriş Yap',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: _loginAsGuest,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGold,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Misafir Olarak Devam Et',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
