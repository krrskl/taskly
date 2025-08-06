import '../../domain/entities/todo.dart' show Todo;

class TodoListState {
  const TodoListState({
    this.todos = const [],
    this.isLoading = false,
    this.error,
    this.filter = TodoFilter.all,
  });

  final List<Todo> todos;
  final bool isLoading;
  final String? error;
  final TodoFilter filter;

  TodoListState copyWith({
    List<Todo>? todos,
    bool? isLoading,
    String? error,
    TodoFilter? filter,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      filter: filter ?? this.filter,
    );
  }

  List<Todo> get filteredTodos {
    switch (filter) {
      case TodoFilter.all:
        return todos;
      case TodoFilter.completed:
        return todos.where((todo) => todo.completed).toList();
      case TodoFilter.pending:
        return todos.where((todo) => !todo.completed).toList();
    }
  }
}

enum TodoFilter { all, completed, pending }
