import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/startup_provider.dart';
import 'startup_error_widget.dart';
import 'startup_loading_widget.dart';

class StartupWidget extends ConsumerWidget {
  final WidgetBuilder onLoaded;

  const StartupWidget({super.key, required this.onLoaded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(startupProvider);

    return appStartupState.when(
      data: (_) => onLoaded(context),
      loading: () => const StartupLoadingWidget(),
      error: (e, st) => StartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(startupProvider),
      ),
    );
  }
}