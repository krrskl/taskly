import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'font_weights.dart';

class TextStyles {
  const TextStyles._();

  static const _baseTextStyle = TextStyle(
    fontWeight: AppFontWeight.medium,
    letterSpacing: -.5,
    color: kWhiteColor,
  );

  static TextStyle headlineSmall = _baseTextStyle.copyWith(fontSize: 20);

  static TextStyle headlineLarge = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle headlineMedium = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: AppFontWeight.semiBold,
    color: kErrorColor,
  );

  static TextStyle displayLarge = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: AppFontWeight.semiBold,
    color: kErrorColor,
  );

  static TextStyle bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
  );

  static TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: kWhiteColor.withValues(alpha: .75),
  );

  static TextStyle bodyLarge = _baseTextStyle.copyWith(fontSize: 16);

  static TextStyle titleLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    letterSpacing: -.4,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle labelSmall = _baseTextStyle.copyWith(fontSize: 12);

  static TextStyle labelMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: kWhiteColor.withValues(alpha: .8),
  );

  static TextStyle titleSmall = _baseTextStyle.copyWith(
    fontSize: 13,
    color: kWhiteColor.withValues(alpha: .6),
  );
}
