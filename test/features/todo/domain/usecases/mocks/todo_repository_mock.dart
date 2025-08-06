import 'package:taskly/core/error/failure.dart';
import 'package:taskly/core/utils/result.dart';
import 'package:taskly/features/todo/domain/entities/todo.dart';
import 'package:taskly/features/todo/domain/repositories/todo_repository.dart';

class MockTodoRepository implements TodoRepository {
  Todo? _storedTodo;
  Failure? _failureToReturn;
  bool _shouldFailOnGet = false;
  bool _shouldFailOnUpdate = false;

  void setTodo(Todo todo) => _storedTodo = todo;
  void setGetFailure(Failure failure) {
    _failureToReturn = failure;
    _shouldFailOnGet = true;
  }

  void setUpdateFailure(Failure failure) {
    _failureToReturn = failure;
    _shouldFailOnUpdate = true;
  }

  void reset() {
    _storedTodo = null;
    _failureToReturn = null;
    _shouldFailOnGet = false;
    _shouldFailOnUpdate = false;
  }

  @override
  Future<Result<Todo>> getTodoById(int id) async {
    if (_shouldFailOnGet) {
      return Error(_failureToReturn!);
    }
    if (_storedTodo == null || _storedTodo!.id != id) {
      return Error(DatabaseFailure(message: 'Todo with id $id not found'));
    }
    return Success(_storedTodo!);
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    if (_shouldFailOnUpdate) {
      return Error(_failureToReturn!);
    }
    _storedTodo = todo;
    return Success(todo);
  }

  @override
  Future<Result<List<Todo>>> getAllTodos() async => Success([]);

  @override
  Future<Result<List<Todo>>> getTodosFromRemote() async => Success([]);

  @override
  Future<Result<List<Todo>>> getTodosByStatus(bool completed) async =>
      Success([]);

  @override
  Future<Result<Todo>> addTodo(Todo todo) async => Success(todo);

  @override
  Future<Result<void>> deleteTodo(int id) async => Success(null);
}
