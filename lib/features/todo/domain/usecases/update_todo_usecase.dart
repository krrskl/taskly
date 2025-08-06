import '../../../../../core/utils/result.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  const UpdateTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<Todo>> call({
    required int id,
    required String title,
    String? description,
  }) async {
    final todoResult = await _repository.getTodoById(id);

    return todoResult.fold((todo) async {
      final updatedTodo = todo.copyWith(
        title: title,
        description: description,
        updatedAt: DateTime.now(),
      );

      return await _repository.updateTodo(updatedTodo);
    }, (failure) async => Error<Todo>(failure));
  }
}
