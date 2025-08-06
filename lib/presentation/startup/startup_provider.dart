import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taskly/core/configs/environment.dart';
import 'package:taskly_ui/utils/logger.dart' show Logger;

part 'startup_provider.g.dart';

@riverpod
Future<void> startup(Ref ref) async {
  EnvironmentConfig.instance.load();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  registerErrorHandlers();
}

void registerErrorHandlers() {
  if (kReleaseMode) return;

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    Logger.printDebug(details.toString());
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    Logger.printDebug(error.toString());
    return true;
  };
}
