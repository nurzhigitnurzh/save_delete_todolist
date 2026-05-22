
import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/database/todo.dart';

class HomeViewModel {
  final AppRepositoryImpl repo;
  List<Todo> todoList = [];

  HomeViewModel({required this.repo});

  List<Todo> getTodoList() {
    todoList = repo.getTodoList();
    return todoList;
  }
}