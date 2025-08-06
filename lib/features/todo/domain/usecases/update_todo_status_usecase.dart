import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoStatusUseCase {
  const UpdateTodoStatusUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<Todo>> call(int todoId, bool completed) async {
    final todoResult = await _repository.getTodoById(todoId);

    return todoResult.fold((todo) async {
      final updatedTodo = todo.copyWith(
        completed: completed,
        updatedAt: DateTime.now(),
      );

      return await _repository.updateTodo(updatedTodo);
    }, (failure) async => Error<Todo>(failure));
  }
}
