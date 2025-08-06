import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/taskly_ui.dart';

import '../providers/country_list_provider.dart';
import 'country_card.dart';

class CountryListWidget extends ConsumerWidget {
  const CountryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryListState = ref.watch(countryListProvider);

    if (countryListState.countries.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: paddingAllRegular,
      itemCount: countryListState.countries.length,
      itemBuilder: (context, index) {
        final country = countryListState.countries[index];
        return CountryCard(country: country);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.public_off, size: 70, color: context.colorScheme.outline),
          verticalSpaceSmall,
          Text(
            t.countries.empty,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
