import 'package:flutter_application_3/database/app_repository.dart';
import 'package:flutter_application_3/database/todo.dart';

class AddViewModel {
  final AppRepository repo;

  AddViewModel({required this.repo});

  void addTodo(Todo todo) {
    repo.addTodo(todo);
  }

}