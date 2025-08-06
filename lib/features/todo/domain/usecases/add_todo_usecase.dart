import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodoUseCase {
  const AddTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<Todo>> call({
    required String title,
    String? description,
    bool completed = false,
  }) async {
    final now = DateTime.now();
    final todo = Todo(
      id: 0,
      title: title,
      description: description,
      completed: completed,
      createdAt: now,
      updatedAt: now,
    );

    return await _repository.addTodo(todo);
  }
}
