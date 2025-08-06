import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/router/routes.dart';
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/taskly_ui.dart';
import 'package:taskly_ui/typography/font_weights.dart' show AppFontWeight;

import '../../domain/entities/todo.dart';
import '../providers/todo_details_provider.dart';
import '../providers/todo_list_provider.dart' show todoListProvider;
import '../providers/todo_providers.dart';

class TodoDetailsScreen extends ConsumerWidget {
  final int todoId;

  const TodoDetailsScreen({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsyncValue = ref.watch(todoDetailsProvider(todoId));
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.8,
      child: SingleChildScrollView(
        child: todoAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              _buildErrorWidget(context, error.toString()),
          data: (todo) => todo != null
              ? _buildTodoDetails(context, todo, ref)
              : _buildErrorWidget(context, 'Todo not found'),
        ),
      ),
    );
  }

  Widget _buildTodoDetails(BuildContext context, Todo todo, WidgetRef ref) {
    return Padding(
      padding: paddingAllRegular,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionCard(
            title: t.todo.details.sections.status.title,
            children: [
              Text(
                todo.completed ? t.commons.status.completed : t.commons.status.pending,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          verticalSpaceMedium,

          CustomSectionCard(
            title: t.todo.details.sections.information.title,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.title,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  horizontalSpaceSmall,
                  Flexible(
                    child: Text(
                      todo.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              if (todo.description != null && todo.description!.isNotEmpty) ...[
                verticalSpaceSmall,
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    horizontalSpaceSmall,
                    Flexible(
                      child: Text(
                        todo.description!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),

          verticalSpaceMedium,

          CustomSectionCard(
            title: t.todo.details.sections.actions.title,
            children: [
              SizedBox(
                width: double.infinity,
                height: 88,
                child: Row(
                  spacing: 10,
                  children: [
                    ShortcutItem(
                      title: t.todo.details.sections.actions.edit,
                      icon: Icons.edit,
                      textColor: context.colorScheme.primary,
                      disabled: todo.completed,
                      disabledIconColor: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      disabledTextColor: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.createTask,
                          arguments: todo.id,
                        );
                      },
                    ),
                    ShortcutItem(
                      title: t.todo.details.sections.actions.delete,
                      icon: Icons.delete,
                      disabled: todo.completed,
                      disabledIconColor: context.colorScheme.onErrorContainer
                          .withValues(alpha: 0.3),
                      disabledTextColor: context.colorScheme.onErrorContainer
                          .withValues(alpha: 0.6),
                      backgroundColor: context.colorScheme.errorContainer,
                      iconColor: context.colorScheme.onErrorContainer,
                      textColor: context.colorScheme.onErrorContainer,
                      onPressed: () {
                        HapticFeedback.lightImpact();

                        showModalBottomSheet(
                          context: context,
                          builder: (_) => ConfirmDeletionSheet(
                            todo: todo,
                            onConfirm: () async {
                              HapticFeedback.lightImpact();
                              await ref
                                  .read(deleteTodoUseCaseProvider)
                                  .call(todo.id);

                              if (context.mounted) {
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                                ref.read(todoListProvider.notifier).loadTodos();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          verticalSpaceMedium,

          CustomSectionCard(
            title: t.todo.details.sections.details.title,
            children: [
              _buildDetailRow(context, 'ID:', todo.id.toString()),
              verticalSpaceSmall,
              _buildDetailRow(
                context,
                t.todo.details.sections.details.fields.createdAt,
                _formatDateTime(todo.createdAt),
              ),
              verticalSpaceSmall,
              _buildDetailRow(
                context,
                t.todo.details.sections.details.fields.updatedAt,
                _formatDateTime(todo.updatedAt),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.primary.withValues(alpha: .7),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 70, color: context.colorScheme.error),
          verticalSpaceRegular,
          Text(
            'Error: $error',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class ConfirmDeletionSheet extends ConsumerWidget {
  final Todo todo;
  final VoidCallback onConfirm;

  const ConfirmDeletionSheet({
    super.key,
    required this.todo,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: paddingAllMedium,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.warning_rounded,
                    color: context.colorScheme.onErrorContainer,
                    size: 20,
                  ),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Text(
                    t.todo.details.deleteConfirmation.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.error,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceRegular,
            Text(
              t.todo.details.deleteConfirmation.message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.colorScheme.onSurfaceVariant,
                      side: BorderSide(
                        color: context.colorScheme.outline.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    child: Text(t.todo.details.deleteConfirmation.cancel),
                  ),
                ),
                horizontalSpaceRegular,
                Expanded(
                  child: CustomPrimaryButton(
                    color: context.colorScheme.error,
                    onPressed: onConfirm,
                    text: t.todo.details.deleteConfirmation.confirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
