import 'package:flutter/material.dart';

import '../typography/text_styles.dart';
import 'colors.dart';

enum AppTheme { light, dark }

TextTheme get _textTheme => TextTheme(
  displayLarge: TextStyles.displayLarge,
  headlineSmall: TextStyles.headlineSmall,
  headlineMedium: TextStyles.headlineMedium,
  headlineLarge: TextStyles.headlineLarge,
  bodySmall: TextStyles.bodySmall,
  bodyMedium: TextStyles.bodyMedium,
  bodyLarge: TextStyles.bodyLarge,
  titleSmall: TextStyles.titleSmall,
  titleLarge: TextStyles.titleLarge,
  labelSmall: TextStyles.labelSmall,
  labelMedium: TextStyles.labelMedium,
);

final appThemes = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldColor,
    textTheme: _textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      tertiary: kTertiaryColor,
      surface: kCardColor,
      surfaceTint: Colors.transparent,
      brightness: Brightness.light,
      error: kErrorColor,
      onPrimary: kWhiteColor,
      onSecondary: kWhiteColor,
      onSurface: kDarkColor,
      outline: kBorderColor,
    ),
    appBarTheme: AppBarTheme(
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      iconTheme: IconThemeData(
        color: kPrimaryColor,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: kCardColor,
      selectedColor: kPrimaryColor,
      checkmarkColor: kWhiteColor,
    ),
  ),
};
