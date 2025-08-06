import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/todo.dart' as domain;

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  const TodoModel({
    required this.id,
    required this.title,
    this.description,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String? description;
  final bool completed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  domain.Todo toDomain() {
    return domain.Todo(
      id: id,
      title: title,
      description: description,
      completed: completed,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  factory TodoModel.fromDomain(domain.Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      completed: todo.completed,
      createdAt: todo.createdAt,
      updatedAt: todo.updatedAt,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
