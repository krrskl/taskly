import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/configs/languages.dart' show supportedLocales;
import 'package:taskly/core/router/routes.dart' show AppRoutes;
import 'package:taskly/presentation/features/countries/presentation/screens/countries_screen.dart';
import 'package:taskly/presentation/features/todo/presentation/screens/create_todo_screen.dart';
import 'package:taskly/presentation/features/todo/presentation/screens/home_sreeen.dart';
import 'package:taskly/presentation/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:taskly/presentation/splash/presentation/screens/splash_screen.dart';
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
      initialRoute: AppRoutes.splash,
      supportedLocales: supportedLocales,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.onboarding: (_) => const OnboardingScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.createTask: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          
          return CreateTodoScreen(todoId: args is int ? args : null);
        },
        AppRoutes.countries: (_) => CountriesScreen(),
      },
    );
  }
}
