import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/utils/result.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecases/get_all_countries_usecase.dart';
import 'country_providers.dart';

part 'country_list_provider.g.dart';

class CountryListState {
  const CountryListState({
    this.countries = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Country> countries;
  final bool isLoading;
  final String? error;

  CountryListState copyWith({
    List<Country>? countries,
    bool? isLoading,
    String? error,
  }) {
    return CountryListState(
      countries: countries ?? this.countries,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

@riverpod
class CountryList extends _$CountryList {
  late GetAllCountriesUseCase _getAllCountriesUseCase;

  @override
  CountryListState build() {
    _getAllCountriesUseCase = ref.watch(getAllCountriesUseCaseProvider);
    return const CountryListState();
  }

  Future<void> loadCountries() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getAllCountriesUseCase();

    result.fold(
      (countries) {
        state = state.copyWith(
          countries: countries,
          isLoading: false,
          error: null,
        );
      },
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
