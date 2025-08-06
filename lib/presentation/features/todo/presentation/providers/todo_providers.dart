import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taskly/core/configs/environment.dart';
import 'package:taskly_api_client/taskly_api_client.dart' show HttpClientImpl;

import '../../data/datasources/local/todo_drift_database.dart';
import '../../data/datasources/local/todo_drift_datasource_impl.dart';
import '../../data/datasources/todo_api_datasource.dart';
import '../../data/datasources/todo_local_datasource.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_all_todos_usecase.dart';
import '../../domain/usecases/get_todo_by_id_usecase.dart';
import '../../domain/usecases/get_todos_by_status_usecase.dart';
import '../../domain/usecases/update_todo_status_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

part 'todo_providers.g.dart';

@riverpod
TodoDriftDatabase todoDriftDatabase(Ref ref) {
  return TodoDriftDatabase();
}

@riverpod
TodoLocalDataSource todoLocalDataSource(Ref ref) {
  final database = ref.watch(todoDriftDatabaseProvider);
  return TodoDriftDataSourceImpl(database);
}

@riverpod
HttpClientImpl httpClient(Ref ref) {
  return HttpClientImpl(baseUrl: EnvironmentConfig.instance.typicodeApiUrl);
}

@riverpod
TodoApiDatasource todoApiDatasource(Ref ref) {
  final http = ref.watch(httpClientProvider);
  return TodoApiDatasource(http: http);
}

@riverpod
TodoRepository todoRepository(Ref ref) {
  final localDataSource = ref.watch(todoLocalDataSourceProvider);
  final remoteDataSource = ref.watch(todoApiDatasourceProvider);

  return TodoRepositoryImpl(localDataSource, remoteDataSource);
}

@riverpod
GetAllTodosUseCase getAllTodosUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetAllTodosUseCase(repository);
}

@riverpod
GetTodosByStatusUseCase getTodosByStatusUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodosByStatusUseCase(repository);
}

@riverpod
UpdateTodoStatusUseCase updateTodoStatusUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return UpdateTodoStatusUseCase(repository);
}

@riverpod
GetTodoByIdUseCase getTodoByIdUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodoByIdUseCase(repository);
}

@riverpod
AddTodoUseCase addTodoUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return AddTodoUseCase(repository);
}

@riverpod
UpdateTodoUseCase updateTodoUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return UpdateTodoUseCase(repository);
}

@riverpod
DeleteTodoUseCase deleteTodoUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return DeleteTodoUseCase(repository);
}

@riverpod
GetTodosFromRemoteUseCase getTodosFromRemoteUseCase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodosFromRemoteUseCase(repository);
}
