import 'package:flutter/material.dart';

import '../../extensions/build_context.extensions.dart'
    show ColorSchemeX, TextThemeX;
import '../theme/spacing.dart' show verticalSpaceTiny;
import '../typography/font_weights.dart' show AppFontWeight;

class ShortcutItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final void Function()? onPressed;
  final bool? disabled;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? iconColor;
  final Color? disabledIconColor;
  final Color? textColor;
  final Color? disabledTextColor;

  const ShortcutItem({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.disabled = false,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.iconColor,
    this.disabledIconColor,
    this.textColor,
    this.disabledTextColor,
  });

  @override
  State<ShortcutItem> createState() => _ShortcutItemState();
}

class _ShortcutItemState extends State<ShortcutItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.disabled!) {
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.disabled!) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (!widget.disabled!) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: !widget.disabled! ? widget.onPressed : null,
          child: SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: !widget.disabled!
                        ? widget.backgroundColor ??
                              Colors.white.withValues(alpha: 0.9)
                        : widget.disabledBackgroundColor ??
                              Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                    boxShadow: !widget.disabled!
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                    border: Border.all(
                      color: !widget.disabled!
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon,
                      size: 24,
                      color: !widget.disabled!
                          ? widget.iconColor ?? context.colorScheme.primary
                          : widget.disabledIconColor ??
                                context.colorScheme.onSurface.withValues(
                                  alpha: 0.3,
                                ),
                    ),
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: !widget.disabled!
                        ? widget.textColor ?? Colors.white
                        : widget.disabledTextColor ??
                              Colors.white.withValues(alpha: 0.6),
                    fontWeight: AppFontWeight.medium,
                    fontSize: 11,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
