import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_3/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
  //Просмотерл ли пользователь онбординги
 // final isOnboardShown = 
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  const MyApp({super.key, required this.isDarkTheme});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late bool isDarkTheme;
  late bool isOnboardShown;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkTheme = widget.isDarkTheme;
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(isDarkTheme: isDarkTheme, onThemeChanged: changeTheme), //корневой экран - всегда висит в памяти
    );
  }

  void changeTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }
}