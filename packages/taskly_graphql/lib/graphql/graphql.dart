import 'package:graphql_flutter/graphql_flutter.dart';

import '../contracts/graphql.dart';

export 'queries/queries.dart';

class GraphqlImpl implements GraphQL {
  final GraphQLClient client;

  GraphqlImpl(this.client);

  @override
  Future<Map<String, dynamic>> query(
    String query, {
    Map<String, dynamic>? variables,
  }) {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );

    return client.query(options).then((result) {
      if (result.hasException) {
        throw result.exception!;
      }
      return result.data ?? {};
    });
  }
}
