import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/database/todo.dart';
 
class DetailViewModel {
  final AppRepository repo;
 
  DetailViewModel({required this.repo});
 
  void updateTodo(int index, Todo todo) {
    repo.updateTodo(index, todo);
  }
 
  void deleteTodo(int index) {
    repo.deleteTodo(index);
  }
}
 