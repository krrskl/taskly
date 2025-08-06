import '../../../../../core/utils/result.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUseCase {
  const DeleteTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<Result<void>> call(int todoId) async {
    final todoResult = await _repository.getTodoById(todoId);

    return todoResult.fold((todo) async {
      return await _repository.deleteTodo(todoId);
    }, (failure) async => Error<void>(failure));
  }
}
