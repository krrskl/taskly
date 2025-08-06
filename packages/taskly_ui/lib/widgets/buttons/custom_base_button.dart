import 'package:flutter/material.dart';

import '../../extensions/build_context.extensions.dart' show ColorSchemeX, TextThemeX;
import '../../theme/borders.dart' show borderRadiusSmall;
import '../../theme/spacing.dart';
import '../../typography/font_weights.dart' show AppFontWeight;
import '../custom_circular_loading.dart' show CustomCircularLoading;

enum ButtonSize { small, medium, large }

extension on ButtonSize {
  double get fontSize {
    switch (this) {
      case ButtonSize.small:
        return 13;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }

  double get height {
    switch (this) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 40;
      case ButtonSize.large:
        return 52;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case ButtonSize.small:
        return edgeSymmetricHorizontalTiny;
      case ButtonSize.medium:
      case ButtonSize.large:
        return edgeSymmetricHorizontalSmall;
    }
  }
}

class CustomBaseButton extends StatelessWidget {
  const CustomBaseButton({
    super.key,
    this.onPressed,
    this.color,
    this.text,
    this.textColor,
    this.iconColor,
    this.size = ButtonSize.medium,
    this.centered = true,
    this.textStyle,
    this.padding,
    this.child,
    this.rawSize,
    this.borderRadius = borderRadiusSmall,
    this.loading = false,
    this.disabled = false,
  });

  final void Function()? onPressed;
  final Color? color;
  final String? text;
  final Color? textColor;
  final Color? iconColor;
  final ButtonSize size;
  final bool centered;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final double? rawSize;
  final BorderRadiusGeometry borderRadius;
  final bool loading;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadiusSmall,
      child: SizedBox(
        height: size.height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            disabledBackgroundColor: context.colorScheme.onPrimary.withValues(alpha: .1),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            padding: padding ?? size.padding,
          ),
          onPressed: onPressed,
          child: child ??
              Row(
                mainAxisAlignment: centered
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  if (text != null) ...[
                    Text(
                      text!,
                      style: textStyle ??
                          context.textTheme.titleLarge?.copyWith(
                            color: !disabled
                                ? textColor
                                : context.colorScheme.onPrimary.withValues(alpha: .1),
                            fontSize: size.fontSize,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                    ),
                  ],
                  if (loading) ...[
                    Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(left: 8.0),
                      padding: const EdgeInsets.all(2.0),
                      child: CustomCircularLoading(
                        color: context.colorScheme.onPrimary.withValues(
                          alpha: .6,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
        ),
      ),
    );
  }
}
