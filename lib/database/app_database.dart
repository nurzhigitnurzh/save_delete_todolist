import 'package:flutter_application_3/database/todo.dart';
import 'package:hive/hive.dart';
 
class AppDatabase {
 
  final Box box = Hive.box('todoBox');
 
  List<Todo> _todoList = [];
 
  AppDatabase() {
    loadTodos();
  }
 
  // hive -> dart
  void loadTodos() {
    final data = box.get('todos', defaultValue: []);
 
    _todoList = List<Map>.from(data).map((e) {
      return Todo(
        id: e['id'],
        title: e['title'],
        isDone: e['isDone'],
        createdAt: e['createdAt'],
      );
    }).toList();
  }
 
  // dart -> hive
  void saveTodos() {
    final data = _todoList.map((todo) {
      return {
        "id": todo.id,
        "title": todo.title,
        "isDone": todo.isDone,
        "createdAt": todo.createdAt
      };
    }).toList();
 
    box.put('todos', data);
  }
 
  // CRUD operations
 
  // CREATE
  void addTodo(Todo todo) {
    _todoList.insert(0, todo);
    saveTodos();
  }
 
  // READ
  List<Todo> getTodoList() {
    return _todoList;
  }
 
  // UPDATE
  void updateTodo(int index, Todo todo) {
    _todoList[index] = todo;
    saveTodos();
  }
 
  // DELETE
  void deleteTodo(int index) {
    _todoList.removeAt(index);
    saveTodos();
  }
}