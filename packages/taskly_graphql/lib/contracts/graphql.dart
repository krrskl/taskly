abstract class GraphQL {
  Future<Map<String, dynamic>> query(String query, {Map<String, dynamic>? variables});
}