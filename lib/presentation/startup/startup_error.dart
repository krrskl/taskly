import 'package:flutter/material.dart';
import 'package:taskly_ui/taskly_ui.dart' show TextThemeX;
import 'package:taskly_ui/theme/taskly_theme.dart' show appThemes, AppTheme;

class StartupErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const StartupErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemes[AppTheme.light],
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: context.textTheme.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: Text('Retry!', style: context.textTheme.labelLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
