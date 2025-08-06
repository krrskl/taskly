import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/result.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_api_datasource.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final TodoLocalDataSource _localDataSource;
  final TodoRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<Todo>>> getAllTodos() async {
    try {
      final todoModels = await _localDataSource.getAllTodos();
      final todos = todoModels.map((model) => model.toDomain()).toList();
      return Success(todos);
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }

  Future<Result<List<Todo>>> getTodosFromRemote() async {
    try {
      final todoModels = await _remoteDataSource.getAllTodos();
      final todos = todoModels.take(10).map((model) => model.toDomain()).toList();
      return Success(todos);
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<Todo>>> getTodosByStatus(bool completed) async {
    try {
      final todoModels = await _localDataSource.getTodosByStatus(completed);
      final todos = todoModels.map((model) => model.toDomain()).toList();
      return Success(todos);
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Todo>> getTodoById(int id) async {
    try {
      final todoModel = await _localDataSource.getTodoById(id);
      if (todoModel == null) {
        return Error(DatabaseFailure(message: 'Todo with id $id not found'));
      }
      return Success(todoModel.toDomain());
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Todo>> addTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromDomain(todo);
      final addedModel = await _localDataSource.addTodo(todoModel);
      return Success(addedModel.toDomain());
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromDomain(todo);
      final updatedModel = await _localDataSource.updateTodo(todoModel);
      return Success(updatedModel.toDomain());
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteTodo(int id) async {
    try {
      await _localDataSource.deleteTodo(id);
      return Success(null);
    } catch (e) {
      return Error(DatabaseFailure(message: e.toString()));
    }
  }
}
