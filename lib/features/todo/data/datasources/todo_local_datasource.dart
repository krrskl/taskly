import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getAllTodos();
  Future<List<TodoModel>> getTodosByStatus(bool completed);
  Future<TodoModel?> getTodoById(int id);
  Future<TodoModel> addTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
}
