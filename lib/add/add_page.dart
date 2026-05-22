import 'package:flutter/material.dart';
import 'package:flutter_application_3/add/add_view_model.dart';
import 'package:flutter_application_3/database/app_database.dart';
import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/database/todo.dart';

class AddPage extends StatefulWidget {
  final AppDatabase database;
  const AddPage({required this.database});

  @override
  State<StatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
TextEditingController _controller = TextEditingController();
late final AddViewModel vm;
late final AppDatabase db;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Add Page - initState");
    db = widget.database;
    final repo = AppRepositoryImpl(db: db);
    vm = AddViewModel(repo: repo);
  }

  @override
  Widget build(BuildContext context) {
    print("AddPage - build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Новая задача"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: 
                InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Введите название задачи")
            ),
            controller: _controller,
            ),
            TextButton(onPressed: _saveTodo, child: Text("Сохранить"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Add Page - dispose");
  }

  void _saveTodo() {
    final todo = Todo(id: 5, title: _controller.text, isDone: false, createdAt: DateTime.now().toString());
    vm.addTodo(todo);
    Navigator.pop(context, _controller.text);
  }
}