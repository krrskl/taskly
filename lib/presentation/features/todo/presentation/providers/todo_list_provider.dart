import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/utils/result.dart';
import '../../domain/usecases/get_all_todos_usecase.dart';
import '../../domain/usecases/update_todo_status_usecase.dart';
import 'todo_list_state.dart';
import 'todo_providers.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  late GetAllTodosUseCase _getAllTodosUseCase;
  late GetTodosFromRemoteUseCase _getTodosFromRemoteUseCase;
  late UpdateTodoStatusUseCase _updateTodoStatusUseCase;

  @override
  TodoListState build() {
    _getAllTodosUseCase = ref.watch(getAllTodosUseCaseProvider);
    _getTodosFromRemoteUseCase = ref.watch(getTodosFromRemoteUseCaseProvider);
    _updateTodoStatusUseCase = ref.watch(updateTodoStatusUseCaseProvider);

    return const TodoListState();
  }

  Future<void> loadTodos() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getAllTodosUseCase();

    result.fold(
      (todos) {
        state = state.copyWith(todos: todos, isLoading: false);
      },
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> loadFromRemote() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getTodosFromRemoteUseCase();

    result.fold(
      (todos) async {
        final addTodo = ref.read(addTodoUseCaseProvider);

        for (final todo in todos) {
          await addTodo(
            title: todo.title,
            description: todo.description,
            completed: todo.completed,
          );
        }

        loadTodos();
      },
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> toggleTodoStatus(int todoId) async {
    final todo = state.todos.firstWhere((t) => t.id == todoId);

    final result = await _updateTodoStatusUseCase(todoId, !todo.completed);

    result.fold(
      (updatedTodo) {
        final updatedTodos = state.todos.map((t) {
          return t.id == todoId ? updatedTodo : t;
        }).toList();

        state = state.copyWith(todos: updatedTodos);
      },
      (failure) {
        state = state.copyWith(error: failure.message);
      },
    );
  }

  void setFilter(TodoFilter filter) {
    state = state.copyWith(filter: filter);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
