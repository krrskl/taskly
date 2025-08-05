import 'package:flutter/material.dart';
import 'package:taskly_ui/taskly_ui.dart';
import 'package:taskly_ui/theme/taskly_theme.dart' show AppTheme, appThemes;

class StartupLoadingWidget extends StatelessWidget {
  const StartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemes[AppTheme.light],
      themeMode: ThemeMode.light,
      home: const CustomScaffold(child: Center(child: CustomCircularLoading())),
    );
  }
}
