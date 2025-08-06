import 'package:flutter/foundation.dart' show kReleaseMode, FlutterErrorDetails, FlutterError, PlatformDispatcher;
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taskly/core/configs/environment.dart' show EnvironmentConfig;
import 'package:taskly_ui/utils/utils.dart' show Logger;

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
