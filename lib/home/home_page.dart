import 'package:flutter/material.dart';
import 'package:flutter_application_3/add/add_page.dart';
import 'package:flutter_application_3/database/app_database.dart';
import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/detail/detail_page.dart';
import 'package:flutter_application_3/home/home_view_model.dart';
import 'package:flutter_application_3/settings/settings_page.dart';
 
class MyHomePage extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;
 
  const MyHomePage({
    super.key,
    required this.isDarkTheme,
    required this.onThemeChanged,
  });
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  late final HomeViewModel vm;
  late final AppDatabase db;
 
  // Инициализироваться - появиться в памяти
  @override
  void initState() {
    super.initState();
    print("Home Page - initState");
    db = AppDatabase();
    final repo = AppRepositoryImpl(db: db);
    vm = HomeViewModel(repo: repo);
    vm.getTodoList();
  }
 
  // Рисует, строит отображение
  @override
  Widget build(BuildContext context) {
    print("Home Page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Мои задачи"),
        actions: [
          IconButton(
            onPressed: _navigateToSettingsPage,
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: vm.todoList.length,
          itemBuilder: (context, index) {
            final title = vm.todoList[index].title;
            return ListTile(
              title: Text(title),
              trailing: const Icon(Icons.chevron_right),
              // По тапу переходим на экран деталей
              onTap: () => _navigateToDetailPage(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        tooltip: 'Добавить задачу',
        child: const Icon(Icons.add),
      ),
    );
  }
 
  // Уничтожить с памяти, освободить с памяти
  @override
  void dispose() {
    super.dispose();
    print("Home Page - dispose");
  }
 
  void _navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddPage(database: db)),
    );
    if (result != null) {
      print("Добавлено: $result");
      setState(() {
        vm.getTodoList();
      });
    }
  }
 
  void _navigateToDetailPage(int index) async {
    final todo = vm.todoList[index];
    // Передаём db, объект задачи и индекс
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(
          database: db,
          todo: todo,
          index: index,
        ),
      ),
    );
    // Обновляем список после редактирования или удаления
    if (result != null) {
      print("Результат: $result");
      setState(() {
        vm.getTodoList();
      });
    }
  }
 
  void _navigateToSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          isDarkTheme: widget.isDarkTheme,
          onThemeChanged: widget.onThemeChanged,
        ),
      ),
    );
  }
}
 