import 'package:flutter/material.dart';
import 'package:taskly_ui/extensions/build_context.extensions.dart';

import '../../domain/entities/todo.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    this.onLongPress,
  });

  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Checkbox(
          visualDensity: VisualDensity.compact,
          value: todo.completed,
          onChanged: (value) {
            if (value != null) {
              onToggle();
            }
          },
        ),
        title: Text(
          todo.title,
          style: context.textTheme.titleSmall?.copyWith(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed
                ? context.colorScheme.outline
                : context.colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: todo.description != null
            ? Text(
                todo.description!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatDate(todo.createdAt),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ],
        ),
        onTap: onToggle,
        onLongPress: onLongPress,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
}
