import '../models/country_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getAllCountries();
}
