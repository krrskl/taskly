import 'package:drift/drift.dart';

import '../models/todo_model.dart';
import 'local/todo_drift_database.dart' show TodoDriftDatabase, TodosCompanion;
import 'todo_local_datasource.dart';

class TodoDriftDataSource implements TodoLocalDataSource {
  const TodoDriftDataSource(this._database);

  final TodoDriftDatabase _database;

  @override
  Future<List<TodoModel>> getAllTodos() async {
    try {
      final todos = await _database.getAllTodos();
      return todos.map(_mapDriftToModel).toList();
    } catch (e) {
      throw Exception('Failed to get todos: $e');
    }
  }

  @override
  Future<List<TodoModel>> getTodosByStatus(bool completed) async {
    try {
      final todos = await _database.getTodosByStatus(completed);
      return todos.map(_mapDriftToModel).toList();
    } catch (e) {
      throw Exception('Failed to get todos by status: $e');
    }
  }

  @override
  Future<TodoModel?> getTodoById(int id) async {
    try {
      final todo = await _database.getTodoById(id);
      return todo != null ? _mapDriftToModel(todo) : null;
    } catch (e) {
      throw Exception('Failed to get todo by id: $e');
    }
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    try {
      final companion = TodosCompanion(
        title: Value(todo.title),
        description: Value(todo.description),
        completed: Value(todo.completed),
        createdAt: Value(todo.createdAt),
        updatedAt: Value(todo.updatedAt),
      );

      final insertedTodo = await _database.insertTodo(companion);
      return _mapDriftToModel(insertedTodo);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      final companion = TodosCompanion(
        id: Value(todo.id),
        title: Value(todo.title),
        description: Value(todo.description),
        completed: Value(todo.completed),
        createdAt: Value(todo.createdAt),
        updatedAt: Value(todo.updatedAt),
      );

      final updatedTodo = await _database.updateTodo(companion);
      return _mapDriftToModel(updatedTodo);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await _database.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  TodoModel _mapDriftToModel(dynamic driftTodo) {
    return TodoModel(
      id: driftTodo.id,
      title: driftTodo.title,
      description: driftTodo.description,
      completed: driftTodo.completed,
      createdAt: driftTodo.createdAt,
      updatedAt: driftTodo.updatedAt,
    );
  }
}
