import 'package:flutter/material.dart';
import 'package:taskly_ui/extensions/build_context.extensions.dart';
import 'package:taskly_ui/theme/spacing.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
  });

  final String title, text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllRegular,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Icon(icon, size: 100, color: context.colorScheme.primary),
            ),
          ),
          verticalSpaceLarge,
          Text(
            title,
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          verticalSpaceMedium,
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
