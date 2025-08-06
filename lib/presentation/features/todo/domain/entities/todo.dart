import 'package:copy_with_extension/copy_with_extension.dart';

part 'todo.g.dart';

@CopyWith()
class Todo {
  const Todo({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String? description;
  final bool completed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
