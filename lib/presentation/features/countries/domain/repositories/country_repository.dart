import '../../../../../core/utils/result.dart';
import '../entities/country.dart';

abstract class CountryRepository {
  Future<Result<List<Country>>> getAllCountries();
}
