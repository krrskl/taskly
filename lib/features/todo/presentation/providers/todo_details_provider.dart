import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/utils/result.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/get_todo_by_id_usecase.dart';
import 'todo_providers.dart';

part 'todo_details_provider.g.dart';

@riverpod
class TodoDetails extends _$TodoDetails {
  late GetTodoByIdUseCase _getTodoByIdUseCase;

  @override
  AsyncValue<Todo?> build(int todoId) {
    _getTodoByIdUseCase = ref.watch(getTodoByIdUseCaseProvider);
    _loadTodo(todoId);
    return const AsyncValue.loading();
  }

  Future<void> _loadTodo(int todoId) async {
    state = const AsyncValue.loading();

    final result = await _getTodoByIdUseCase(todoId);

    result.fold(
      (todo) {
        state = AsyncValue.data(todo);
      },
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  Future<void> refresh(int todoId) async {
    await _loadTodo(todoId);
  }
}
