import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/router/routes.dart';
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/taskly_ui.dart';

import '../providers/todo_list_provider.dart';
import '../widgets/todo_filter_widget.dart';
import '../widgets/todo_list_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(todoListProvider.notifier).loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoListState = ref.watch(todoListProvider);

    return CustomScaffold(
      title: 'Taskly',
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.createTask),
          icon: const Icon(Icons.add),
          tooltip: t.home.actions.add.tooltip,
          color: context.colorScheme.primary,
        ),
        IconButton(
          onPressed: () => ref.read(todoListProvider.notifier).loadFromRemote(),
          tooltip: t.home.actions.download.tooltip,
          icon: const Icon(Icons.cloud_download_outlined),
          color: context.colorScheme.primary,
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.countries),
          tooltip: t.home.actions.countries.tooltip,
          icon: const Icon(Icons.public),
          color: context.colorScheme.primary,
        ),
      ],
      child: Column(
        children: [
          const TodoFilterWidget(),

          Expanded(
            child: todoListState.isLoading
                ? const Center(child: CustomCircularLoading())
                : todoListState.error != null
                ? CustomErrorWidget(
                    errorMessage: t.commons.errors.unknown,
                    retryMessage: t.commons.actions.retry,
                    onRetry: () {
                      ref.read(todoListProvider.notifier).clearError();
                      ref.read(todoListProvider.notifier).loadTodos();
                    },
                  )
                : const TodoListWidget(),
          ),
        ],
      ),
    );
  }
}
