import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taskly/core/router/routes.dart' show AppRoutes;

import 'settings_provider.dart' show settingsProviderProvider;

part 'splash_provider.g.dart';


@riverpod
Future<String> initialValidations(Ref ref) async {
  await Future.delayed(const Duration(seconds: 1));

  final settings = await ref.read(settingsProviderProvider.future);

  if (settings.firstLaunch) {
    ref.read(settingsProviderProvider.notifier).updateFirstLaunch();
    return AppRoutes.onboarding;
  }

  return AppRoutes.home;
}
