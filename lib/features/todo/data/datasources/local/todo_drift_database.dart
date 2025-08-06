import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/todos.dart';

part 'todo_drift_database.g.dart';

@DriftDatabase(tables: [Todos])
class TodoDriftDatabase extends _$TodoDriftDatabase {
  TodoDriftDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodos() async {
    return await select(todos).get();
  }

  Future<List<Todo>> getTodosByStatus(bool completed) async {
    return await (select(
      todos,
    )..where((t) => t.completed.equals(completed))).get();
  }

  Future<Todo?> getTodoById(int id) async {
    return await (select(
      todos,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Todo> insertTodo(TodosCompanion todo) async {
    return await into(todos).insertReturning(todo);
  }

  Future<Todo> updateTodo(TodosCompanion todo) async {
    return await (update(todos)..where((t) => t.id.equals(todo.id.value)))
        .writeReturning(todo)
        .then((list) => list.first);
  }

  Future<void> deleteTodo(int id) async {
    await (delete(todos)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todos.sqlite'));
    return NativeDatabase(file);
  });
}
