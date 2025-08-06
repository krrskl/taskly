import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/presentation/i18n/translations.g.dart';
import 'package:taskly_ui/taskly_ui.dart';

import '../../../../../core/utils/result.dart';
import '../../domain/entities/todo.dart';
import '../providers/todo_list_provider.dart' show todoListProvider;
import '../providers/todo_providers.dart';

class CreateTodoScreen extends ConsumerStatefulWidget {
  final int? todoId;

  const CreateTodoScreen({super.key, this.todoId});

  @override
  ConsumerState<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends ConsumerState<CreateTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  Todo? _todoToEdit;

  @override
  void initState() {
    super.initState();
    if (widget.todoId != null) {
      _loadTodo();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadTodo() async {
    if (widget.todoId == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final getTodoByIdUseCase = ref.read(getTodoByIdUseCaseProvider);
      final result = await getTodoByIdUseCase(widget.todoId!);

      result.fold(
        (todo) {
          setState(() {
            _todoToEdit = todo;
            _titleController.text = todo.title;
            _descriptionController.text = todo.description ?? '';
            _isLoading = false;
          });
        },
        (failure) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load todo: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveTodo() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      Result<Todo> result;

      if (_todoToEdit != null) {
        final updateTodoUseCase = ref.read(updateTodoUseCaseProvider);
        result = await updateTodoUseCase(
          id: _todoToEdit!.id,
          title: title,
          description: description.isEmpty ? null : description,
        );
      } else {
        final addTodoUseCase = ref.read(addTodoUseCaseProvider);
        result = await addTodoUseCase(
          title: title,
          description: description.isEmpty ? null : description,
        );
      }

      result.fold(
        (todo) {
          ref.read(todoListProvider.notifier).loadTodos();
          Navigator.of(context).pop(true);
        },
        (failure) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to save todo: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todoId != null;
    final title = isEditing
        ? t.todo.create.updateTitle
        : t.todo.create.createTitle;

    return CustomScaffold(
      title: title,
      child: _isLoading && _todoToEdit == null
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null && _todoToEdit == null
          ? _buildErrorWidget()
          : _buildForm(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 70, color: context.colorScheme.error),
          verticalSpaceRegular,
          Text(
            _errorMessage!,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpaceRegular,
          CustomPrimaryButton(
            text: 'Retry',
            onPressed: widget.todoId != null ? _loadTodo : null,
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: paddingAllRegular,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              label: t.todo.create.fields.title.label,
              hintText: t.todo.create.fields.title.hint,
              controller: _titleController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return t.todo.create.fields.title.required;
                }
                if (value.trim().length < 3) {
                  return t.todo.create.fields.title.minLength;
                }
                return null;
              },
              disabled: _isLoading,
            ),

            verticalSpaceMedium,

            CustomFormField(
              label: t.todo.create.fields.description.label,
              hintText: t.todo.create.fields.description.hint,
              controller: _descriptionController,
              textInputAction: TextInputAction.newline,
              maxLines: 4,
              disabled: _isLoading,
            ),

            if (_errorMessage != null) ...[
              verticalSpaceMedium,
              Container(
                padding: paddingAllRegular,
                decoration: BoxDecoration(
                  color: context.colorScheme.errorContainer,
                  borderRadius: borderRadiusRegular,
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: context.colorScheme.error),
                    horizontalSpaceSmall,
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            verticalSpaceLarge,

            CustomPrimaryButton(
              text: widget.todoId != null
                  ? t.todo.create.actions.update
                  : t.todo.create.actions.create,
              loading: _isLoading,
              onPressed: _isLoading ? null : _saveTodo,
            ),
          ],
        ),
      ),
    );
  }
}
