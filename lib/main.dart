import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/presentation/startup/presentation/startup_app.dart' show StartupApp;
import 'package:taskly/presentation/startup/presentation/widgets/startup_widget.dart' show StartupWidget;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: StartupWidget(onLoaded: (context) => const StartupApp()),
    ),
  );
}
