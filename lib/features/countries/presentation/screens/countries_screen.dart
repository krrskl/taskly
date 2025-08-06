import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/presentation/i18n/translations.g.dart' show t;
import 'package:taskly_ui/taskly_ui.dart';

import '../providers/country_list_provider.dart';
import '../widgets/country_list_widget.dart';

class CountriesScreen extends ConsumerStatefulWidget {
  const CountriesScreen({super.key});

  @override
  ConsumerState<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends ConsumerState<CountriesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(countryListProvider.notifier).loadCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final countryListState = ref.watch(countryListProvider);

    return CustomScaffold(
      title: t.countries.title,
      actions: [
        IconButton(
          onPressed: () =>
              ref.read(countryListProvider.notifier).loadCountries(),
          icon: const Icon(Icons.refresh),
          tooltip: t.countries.actions.refresh.tooltip,
          color: context.colorScheme.primary,
        ),
      ],
      child: countryListState.isLoading
          ? const Center(child: CustomCircularLoading())
          : countryListState.error != null
          ? CustomErrorWidget(
              errorMessage: t.commons.errors.unknown,
              retryMessage: t.commons.actions.retry,
              onRetry: () {
                ref.read(countryListProvider.notifier).clearError();
                ref.read(countryListProvider.notifier).loadCountries();
              },
            )
          : const CountryListWidget(),
    );
  }
}
