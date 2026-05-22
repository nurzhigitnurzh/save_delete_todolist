import 'package:flutter/material.dart';
import 'package:flutter_application_3/add/add_page.dart';
import 'package:flutter_application_3/database/app_database.dart';
import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/database/todo.dart';
import 'package:flutter_application_3/home/home_view_model.dart';
import 'package:flutter_application_3/settings/settings_page.dart';
class MyHomePage extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;

  const MyHomePage({super.key, required this.isDarkTheme, required this.onThemeChanged});

//Выделить память
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeViewModel vm;
  late final AppDatabase db;

  //Инициализироваться - появиться в памяти
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Home Page - initState");
    db = AppDatabase();
    final repo = AppRepositoryImpl(db: db);
    vm = HomeViewModel(repo: repo);
    vm.getTodoList();
  }

  //Рисует, строит отображение
  @override
  Widget build(BuildContext context) {
    print("Home Page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Мои задачи"),
        actions: [IconButton(onPressed: _navigateToSettingsPage, icon: Icon(Icons.settings))],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: vm.todoList.length,
          itemBuilder: (context, index) {
            final title = vm.todoList[index].title;
            return ListTile(title: Text(title));
          }
          )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

//Уничтожить с памяти, освободить с памяти
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Home Page - dispose");
  }

  void _navigateToAddPage() async {
   final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddPage(database: db)));
   setState(() {
     vm.getTodoList();
   });
   
   if (result != null) {
    print("$result");
   } 
  }

  void _navigateToSettingsPage() async {
   Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage(isDarkTheme: widget.isDarkTheme, onThemeChanged: widget.onThemeChanged)));
  }
}