import 'package:taskly_api_client/taskly_api_client.dart'
    show APIPaths, HttpClientImpl;

import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getAllTodos();
}

class TodoApiDatasource implements TodoRemoteDataSource {
  final HttpClientImpl _http;

  const TodoApiDatasource({required HttpClientImpl http}) : _http = http;

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final response = await _http.get(APIPaths.todos);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body as List<dynamic>;
      return data.map((item) => TodoModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load todos: ${response.statusCode}');
    }
  }
}
