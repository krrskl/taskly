import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodoByIdUseCase {
  const GetTodoByIdUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<Todo>> call(int id) async {
    return await _repository.getTodoById(id);
  }
}
