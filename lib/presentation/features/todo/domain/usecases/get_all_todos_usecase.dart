import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetAllTodosUseCase {
  const GetAllTodosUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<List<Todo>>> call() async {
    return await _repository.getAllTodos();
  }
}

class GetTodosFromRemoteUseCase {
  const GetTodosFromRemoteUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<List<Todo>>> call() async {
    return await _repository.getTodosFromRemote();
  }
}
