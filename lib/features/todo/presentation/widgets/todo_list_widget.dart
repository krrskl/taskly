import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly_ui/extensions/build_context.extensions.dart';
import 'package:taskly_ui/taskly_ui.dart' show verticalSpaceSmall;

import '../providers/todo_list_provider.dart';
import '../providers/todo_list_state.dart' show TodoFilter;
import '../screens/todo_details_screen.dart' show TodoDetailsScreen;
import 'todo_item_widget.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListProvider);
    final filteredTodos = todoListState.filteredTodos;

    if (filteredTodos.isEmpty) {
      return _buildEmptyState(context, todoListState.filter);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredTodos.length,
      itemBuilder: (context, index) {
        final todo = filteredTodos[index];
        return TodoItemWidget(
          todo: todo,
          onToggle: () {
            ref.read(todoListProvider.notifier).toggleTodoStatus(todo.id);
          },
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => TodoDetailsScreen(todoId: todo.id),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, TodoFilter filter) {
    String message;
    IconData icon;

    switch (filter) {
      case TodoFilter.all:
        message = 'No todos yet.\nAdd some todos to get started!';
        icon = Icons.assignment_outlined;
        break;
      case TodoFilter.completed:
        message =
            'No completed todos yet.\nComplete some tasks to see them here!';
        icon = Icons.check_circle_outline;
        break;
      case TodoFilter.pending:
        message = 'No pending todos.\nGreat job! All tasks are completed!';
        icon = Icons.assignment_turned_in_outlined;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 70, color: context.colorScheme.outline),
          verticalSpaceSmall,
          Text(
            message,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
