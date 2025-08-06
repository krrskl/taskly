import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/core/error/failure.dart';
import 'package:taskly/core/utils/result.dart';
import 'package:taskly/features/todo/domain/entities/todo.dart';
import 'package:taskly/features/todo/domain/usecases/update_todo_status_usecase.dart';

import 'mocks/todo_repository_mock.dart' show MockTodoRepository;

void main() {
  group('UpdateTodoStatusUseCase - Business Logic Tests', () {
    late UpdateTodoStatusUseCase usecase;
    late MockTodoRepository mockTodoRepository;

    setUp(() {
      mockTodoRepository = MockTodoRepository();
      usecase = UpdateTodoStatusUseCase(mockTodoRepository);
    });

    tearDown(() {
      mockTodoRepository.reset();
    });

    group('call', () {
      const todoId = 1;
      const originalCompleted = false;
      const newCompleted = true;

      final initialTestDateTime = DateTime(2023, 1, 1, 12, 0, 0);
      final testTodo = Todo(
        id: todoId,
        title: 'Test Todo',
        description: 'Test Description',
        completed: originalCompleted,
        createdAt: initialTestDateTime,
        updatedAt: initialTestDateTime,
      );

      test(
        'should get todo from repository and update its status successfully',
        () async {
          mockTodoRepository.setTodo(testTodo);

          final result = await usecase.call(todoId, newCompleted);

          expect(result, isA<Success<Todo>>());

          final successResult = result as Success<Todo>;
          expect(successResult.data.id, equals(todoId));
          expect(successResult.data.completed, equals(newCompleted));
          expect(successResult.data.title, equals(testTodo.title));
          expect(successResult.data.description, equals(testTodo.description));
          expect(successResult.data.createdAt, equals(testTodo.createdAt));

          expect(
            successResult.data.updatedAt,
            isNot(equals(testTodo.updatedAt)),
          );
          expect(successResult.data.updatedAt, isA<DateTime>());
        },
      );

      test(
        'should return Error when repository fails to get todo by id',
        () async {
          const tFailure = DatabaseFailure(message: 'Todo not found');
          mockTodoRepository.setGetFailure(tFailure);

          final result = await usecase.call(todoId, newCompleted);

          expect(result, isA<Error<Todo>>());

          final errorResult = result as Error<Todo>;
          expect(errorResult.failure, isA<DatabaseFailure>());
          expect(errorResult.failure.message, equals('Todo not found'));
        },
      );

      test(
        'should return Error when repository fails to update todo',
        () async {
          mockTodoRepository.setTodo(testTodo);
          const tFailure = DatabaseFailure(message: 'Failed to update todo');
          mockTodoRepository.setUpdateFailure(tFailure);

          final result = await usecase.call(todoId, newCompleted);

          expect(result, isA<Error<Todo>>());

          final errorResult = result as Error<Todo>;
          expect(errorResult.failure, isA<DatabaseFailure>());
          expect(errorResult.failure.message, equals('Failed to update todo'));
        },
      );

      test('should handle toggle from completed to incomplete', () async {
        final tCompletedTodo = testTodo.copyWith(completed: true);
        mockTodoRepository.setTodo(tCompletedTodo);

        final result = await usecase.call(todoId, false);

        expect(result, isA<Success<Todo>>());

        final successResult = result as Success<Todo>;
        expect(successResult.data.completed, equals(false));
        expect(successResult.data.id, equals(todoId));
        expect(successResult.data.title, equals(tCompletedTodo.title));
      });

      test('should update timestamp when status changes', () async {
        final originalTime = DateTime(2023, 1, 1, 10, 0, 0);
        final todoWithOldTime = testTodo.copyWith(updatedAt: originalTime);
        mockTodoRepository.setTodo(todoWithOldTime);

        await Future.delayed(Duration(milliseconds: 1));
        final result = await usecase.call(todoId, newCompleted);

        expect(result, isA<Success<Todo>>());

        final successResult = result as Success<Todo>;
        expect(successResult.data.updatedAt, isNot(equals(originalTime)));
        expect(successResult.data.updatedAt!.isAfter(originalTime), isTrue);
      });
    });
  });
}
