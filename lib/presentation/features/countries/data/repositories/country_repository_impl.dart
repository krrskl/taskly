import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/result.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_remote_datasource.dart';

class CountryRepositoryImpl implements CountryRepository {
  const CountryRepositoryImpl(this._remoteDataSource);

  final CountryRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<Country>>> getAllCountries() async {
    try {
      final countryModels = await _remoteDataSource.getAllCountries();
      final countries = countryModels.map((model) => model.toDomain()).toList();
      return Success(countries);
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }
}
