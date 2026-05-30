import 'package:flutter/material.dart';
import 'package:flutter_application_3/database/app_database.dart';
import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/database/todo.dart';
import 'package:flutter_application_3/detail/detail_view_model.dart';
 
class DetailPage extends StatefulWidget {
  final AppDatabase database;
  final Todo todo;
  final int index;
 
  const DetailPage({
    super.key,
    required this.database,
    required this.todo,
    required this.index,
  });
 
  @override
  State<DetailPage> createState() => _DetailPageState();
}
 
class _DetailPageState extends State<DetailPage> {
  late final TextEditingController _controller;
  late final DetailViewModel vm;
 
  @override
  void initState() {
    super.initState();
    print("Detail Page - initState");
    final repo = AppRepositoryImpl(db: widget.database);
    vm = DetailViewModel(repo: repo);
    // Заполняем поле текущим названием задачи
    _controller = TextEditingController(text: widget.todo.title);
  }
 
  @override
  Widget build(BuildContext context) {
    print("Detail Page - build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Детали задачи"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Название задачи"),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _updateTodo,
                child: const Text("Сохранить"),
              ),
              TextButton(
                onPressed: _deleteTodo,
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Удалить"),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    print("Detail Page - dispose");
  }
 
  void _updateTodo() {
    final updatedTodo = Todo(
      id: widget.todo.id,
      title: _controller.text,
      isDone: widget.todo.isDone,
      createdAt: widget.todo.createdAt,
    );
    vm.updateTodo(widget.index, updatedTodo);
    Navigator.pop(context, 'updated');
  }
 
  void _deleteTodo() {
    vm.deleteTodo(widget.index);
    Navigator.pop(context, 'deleted');
  }
}