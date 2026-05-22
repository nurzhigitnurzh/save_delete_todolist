import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/home/home_page.dart';

class OnboardingPage extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;

  const OnboardingPage({
    super.key,
    required this.isDarkTheme,
    required this.onThemeChanged,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    // В initState сохраняем bool - значение, что онбординг просмотрен
    _saveOnboardShown();
  }

  Future<void> _saveOnboardShown() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isOnboardShown', true);
  }

  void _navigateToHome() {
    // Используем pushReplacement, чтобы пользователь не мог вернуться кнопкой "Назад" на онбординг
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MyHomePage(
          isDarkTheme: widget.isDarkTheme,
          onThemeChanged: widget.onThemeChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 120,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 40),
              const Text(
                "Добро пожаловать!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Управляйте своими задачами быстро и удобно. Добавляйте новые дела, отслеживайте прогресс и настраивайте тему приложения.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _navigateToHome,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Начать",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}