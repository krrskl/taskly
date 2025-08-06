import 'package:flutter/material.dart';
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/taskly_ui.dart';

import '../../domain/entities/country.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            children: [
              Text(country.emoji, style: const TextStyle(fontSize: 32)),
              horizontalSpaceRegular,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    if (country.capital != null &&
                        country.capital!.isNotEmpty) ...[
                      verticalSpaceTiny,
                      Text(
                        '${t.countries.country.fields.capital}: ${country.capital}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                country.code,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          verticalSpaceSmall,
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              if (country.currency != null && country.currency!.isNotEmpty)
                _buildInfoChip(
                  context,
                  t.countries.country.fields.currency,
                  country.currency!,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: borderRadiusSmall,
      ),
      child: RichText(
        text: TextSpan(
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
