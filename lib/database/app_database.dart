
import 'package:flutter_application_3/database/todo.dart';

class AppDatabase {
  //mock-данные
  List<Todo> _todoList = [
    Todo(id: 1, title: "Записаться на курсы по flutter", isDone: true, createdAt: "01.03.2026"),
    Todo(id: 2, title: "Прочесть Война и Мир", isDone: false, createdAt: "20.04.2026"),
    Todo(id: 3, title: "Купить новый телефон", isDone: false, createdAt: "1.09.2026"),
    Todo(id: 4, title: "Посмотреть сериал Игра престолов", isDone: false, createdAt: "10.05.2026"),
    ];

    //CRUD operations

    //CREATE
    void addTodo(Todo todo) {
      _todoList.insert(0, todo);
    }

    //READ
    List<Todo> getTodoList() {
      return _todoList;
    }

    //UPDATE
    void updateTodo(int index, String title) {

    }

    //DELETE
    void deleteTodo(int index) {
      
    }

}