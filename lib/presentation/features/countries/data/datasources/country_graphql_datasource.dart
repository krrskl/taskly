import 'package:taskly_graphql/contracts/graphql.dart';
import 'package:taskly_graphql/taskly_graphql.dart' show getCountriesQuery;

import '../models/country_model.dart';
import 'country_remote_datasource.dart';

class CountryGraphqlDataSource implements CountryRemoteDataSource {
  const CountryGraphqlDataSource(this._graphql);

  final GraphQL _graphql;

  @override
  Future<List<CountryModel>> getAllCountries() async {
    try {
      final result = await _graphql.query(getCountriesQuery);

      final countriesData = result['countries'] as List<dynamic>;

      return countriesData
          .map(
            (countryJson) =>
                CountryModel.fromJson(countryJson as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }
}
