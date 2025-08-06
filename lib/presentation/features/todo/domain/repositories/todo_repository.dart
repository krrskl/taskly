import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Result<List<Todo>>> getAllTodos();
  
  Future<Result<List<Todo>>> getTodosFromRemote();

  Future<Result<List<Todo>>> getTodosByStatus(bool completed);

  Future<Result<Todo>> getTodoById(int id);

  Future<Result<Todo>> addTodo(Todo todo);

  Future<Result<Todo>> updateTodo(Todo todo);

  Future<Result<void>> deleteTodo(int id);
}
