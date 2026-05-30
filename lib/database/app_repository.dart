import 'package:flutter_application_3/database/app_database.dart';
import 'package:flutter_application_3/database/todo.dart';
 
abstract class AppRepository {
  // описание методов
  List<Todo> getTodoList();
 
  void addTodo(Todo todo);
 
  void updateTodo(int index, Todo todo);
 
  void deleteTodo(int index);
}
 
// реализация методов
class AppRepositoryImpl extends AppRepository {
  final AppDatabase db;
 
  AppRepositoryImpl({required this.db});
 
  @override
  List<Todo> getTodoList() => db.getTodoList();
 
  @override
  void addTodo(Todo todo) {
    db.addTodo(todo);
  }
 
  @override
  void updateTodo(int index, Todo todo) {
    db.updateTodo(index, todo);
  }
 
  @override
  void deleteTodo(int index) {
    db.deleteTodo(index);
  }
}
 