import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../data/models/settings_model.dart' show SettingsData;

part 'settings_provider.g.dart';

final initialValue = SettingsData(firstLaunch: true);

@riverpod
class SettingsProvider extends _$SettingsProvider {
  static const String _firstLaunchKey = 'firstLaunch1';

  @override
  Future<SettingsData> build() async {
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = prefs.getBool(_firstLaunchKey) ?? true;
    return SettingsData(firstLaunch: firstLaunch);
  }

  Future<void> updateFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);

    final updatedSettings = SettingsData(firstLaunch: false);
    state = AsyncData(updatedSettings);
  }
}
