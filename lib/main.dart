import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/presentation/startup/startup.dart' show StartupWidget;
import 'package:taskly/presentation/startup/startup_app.dart' show StartupApp;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: StartupWidget(onLoaded: (context) => const StartupApp()),
    ),
  );
}
