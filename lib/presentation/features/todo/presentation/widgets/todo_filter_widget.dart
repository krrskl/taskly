import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/extensions/build_context.extensions.dart' show ColorSchemeX, TextThemeX;
import 'package:taskly_ui/theme/spacing.dart' show paddingAllRegular;

import '../providers/todo_list_provider.dart' show todoListProvider;
import '../providers/todo_list_state.dart' show TodoFilter;

class TodoFilterWidget extends ConsumerWidget {
  const TodoFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListProvider);
    final currentFilter = todoListState.filter;

    return Container(
      padding: paddingAllRegular,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          _buildFilterChip(
            context,
            ref,
            t.home.sections.filter.options.all,
            TodoFilter.all,
            currentFilter == TodoFilter.all,
          ),
          _buildFilterChip(
            context,
            ref,
            t.home.sections.filter.options.pending,
            TodoFilter.pending,
            currentFilter == TodoFilter.pending,
          ),
          _buildFilterChip(
            context,
            ref,
            t.home.sections.filter.options.completed,
            TodoFilter.completed,
            currentFilter == TodoFilter.completed,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    TodoFilter filter,
    bool isSelected,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? context.colorScheme.onPrimary
                : context.colorScheme.onSurfaceVariant,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            ref.read(todoListProvider.notifier).setFilter(filter);
          }
        },
      ),
    );
  }
}
