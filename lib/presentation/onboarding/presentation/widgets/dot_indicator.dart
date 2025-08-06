import 'package:flutter/material.dart';
import 'package:taskly_ui/extensions/build_context.extensions.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = context.colorScheme.primary;
    final Color inActiveColor = context.colorScheme.onSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 10 / 2),
      height: 5,
      width: isActive ? 20 : 5,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withValues(alpha: .25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
