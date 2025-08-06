import '../../../../../core/utils/result.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetAllCountriesUseCase {
  const GetAllCountriesUseCase(this._repository);

  final CountryRepository _repository;

  Future<Result<List<Country>>> call() async {
    return await _repository.getAllCountries();
  }
}
