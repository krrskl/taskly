import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/utils/result.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/get_todo_by_id_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import 'todo_providers.dart';

part 'create_todo_provider.g.dart';

@riverpod
class CreateTodo extends _$CreateTodo {
  late AddTodoUseCase _addTodoUseCase;
  late UpdateTodoUseCase _updateTodoUseCase;
  late GetTodoByIdUseCase _getTodoByIdUseCase;

  @override
  AsyncValue<Todo?> build(int? todoId) {
    _addTodoUseCase = ref.watch(addTodoUseCaseProvider);
    _updateTodoUseCase = ref.watch(updateTodoUseCaseProvider);
    _getTodoByIdUseCase = ref.watch(getTodoByIdUseCaseProvider);

    if (todoId != null) {
      _loadTodo(todoId);
      return const AsyncValue.loading();
    }
    
    return const AsyncValue.data(null);
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

  Future<bool> saveTodo({
    required String title,
    String? description,
  }) async {
    if (title.trim().isEmpty) {
      state = AsyncValue.error('Title cannot be empty', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();

    final currentTodo = state.valueOrNull;
    late Result<Todo> result;

    if (currentTodo != null) {
      // Update existing todo
      result = await _updateTodoUseCase(
        id: currentTodo.id,
        title: title.trim(),
        description: description?.trim(),
      );
    } else {
      // Create new todo
      result = await _addTodoUseCase(
        title: title.trim(),
        description: description?.trim(),
      );
    }

    return result.fold(
      (todo) {
        state = AsyncValue.data(todo);
        return true;
      },
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  void clearError() {
    if (state.hasError) {
      final currentTodo = state.valueOrNull;
      state = AsyncValue.data(currentTodo);
    }
  }
}
