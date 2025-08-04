import 'package:flutter/material.dart';

import '../custom_circular_loading.dart';

class CustomIconButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool disabled;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomIconButton({
    super.key,
    required this.loading,
    this.onPressed,
    this.backgroundColor,
    required this.icon,
    required this.disabled,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final customBackgroundColor = backgroundColor ?? colorScheme.onPrimary;
    final color = disabled
        ? colorScheme.onSurface.withAlpha(100)
        : colorScheme.primary;

    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          disabled
              ? customBackgroundColor.withAlpha(100)
              : customBackgroundColor,
        ),
      ),
      icon: loading
          ? const CustomCircularLoading()
          : Icon(icon, color: iconColor ?? color),
      onPressed: disabled ? null : onPressed,
    );
  }
}
