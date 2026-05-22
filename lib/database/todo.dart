//модель данных для задачи
class Todo {
  final int id;
  final String title;
  final bool isDone;
  final String createdAt;

  Todo(
    {
    required this.id, 
    required this.title, 
    required this.isDone, 
    required this.createdAt
    });  
}