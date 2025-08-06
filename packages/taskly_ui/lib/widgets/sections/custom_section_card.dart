import 'package:flutter/material.dart';

import '../../extensions/build_context.extensions.dart';
import '../../theme/borders.dart' show borderRadiusRegular;
import '../../theme/spacing.dart' show paddingAllRegular, verticalSpaceRegular;
import '../../typography/font_weights.dart' show AppFontWeight;

class CustomSectionCard extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final List<Widget> children;

  const CustomSectionCard({
    super.key,
    this.title,
    this.trailing,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: paddingAllRegular,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: borderRadiusRegular,
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: AppFontWeight.medium,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
              if (trailing != null) ...[trailing!],
            ],
          ),
          if (title != null) ...[verticalSpaceRegular],
          ...children,
        ],
      ),
    );
  }
}
