import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/home/home_page.dart';
import 'package:flutter_application_3/onboarding/onboarding_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
  
  // Считываем, просмотрел ли пользователь онбординги
  final isOnboardShown = preferences.getBool('isOnboardShown') ?? false;

  runApp(MyApp(isDarkTheme: isDarkTheme, isOnboardShown: isOnboardShown));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  final bool isOnboardShown;

  const MyApp({super.key, required this.isDarkTheme, required this.isOnboardShown});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkTheme;
  late bool isOnboardShown;

  @override
  void initState() {
    super.initState();
    isDarkTheme = widget.isDarkTheme;
    isOnboardShown = widget.isOnboardShown;
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      // Делаем проверку и указываем стартовый экран
      home: isOnboardShown 
          ? MyHomePage(isDarkTheme: isDarkTheme, onThemeChanged: changeTheme)
          : OnboardingPage(isDarkTheme: isDarkTheme, onThemeChanged: changeTheme), 
    );
  }

  void changeTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }
}