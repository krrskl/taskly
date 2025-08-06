import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taskly/core/configs/environment.dart';
import 'package:taskly_graphql/contracts/graphql.dart';
import 'package:taskly_graphql/graphql/graphql.dart';

import '../../data/datasources/country_graphql_datasource.dart';
import '../../data/datasources/country_remote_datasource.dart';
import '../../data/repositories/country_repository_impl.dart';
import '../../domain/repositories/country_repository.dart';
import '../../domain/usecases/get_all_countries_usecase.dart';

part 'country_providers.g.dart';

@riverpod
GraphQLClient graphqlClient(Ref ref) {
  final Link link = HttpLink(EnvironmentConfig.instance.countryApiUrl);

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}

@riverpod
GraphQL graphql(Ref ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphqlImpl(client);
}

@riverpod
CountryRemoteDataSource countryRemoteDataSource(Ref ref) {
  final graphql = ref.watch(graphqlProvider);
  return CountryGraphqlDataSource(graphql);
}

@riverpod
CountryRepository countryRepository(Ref ref) {
  final remoteDataSource = ref.watch(countryRemoteDataSourceProvider);
  return CountryRepositoryImpl(remoteDataSource);
}

@riverpod
GetAllCountriesUseCase getAllCountriesUseCase(Ref ref) {
  final repository = ref.watch(countryRepositoryProvider);
  return GetAllCountriesUseCase(repository);
}
