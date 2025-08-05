import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/configs/languages.dart' show supportedLocales;
import 'package:taskly/core/router/routes.dart' show AppRoutes;
import 'package:taskly_ui/theme/taskly_theme.dart' show AppTheme, appThemes;

class StartupApp extends ConsumerWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const StartupApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Taskly - Todo App',
      theme: appThemes[AppTheme.light],
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.home,
      supportedLocales: supportedLocales,
      routes: {
        AppRoutes.home: (_) => const Placeholder(),
      },
    );
  }
}
