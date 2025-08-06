import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosByStatusUseCase {
  const GetTodosByStatusUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<List<Todo>>> call(bool completed) async {
    return await _repository.getTodosByStatus(completed);
  }
}
