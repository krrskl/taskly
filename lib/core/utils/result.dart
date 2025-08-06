import '../error/failure.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Error<T> extends Result<T> {
  const Error(this.failure);
  final Failure failure;
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;

  bool get isError => this is Error<T>;

  T? get dataOrNull => switch (this) {
    Success(data: final data) => data,
    Error() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Success() => null,
    Error(failure: final failure) => failure,
  };

  R fold<R>(R Function(T data) onSuccess, R Function(Failure failure) onError) {
    return switch (this) {
      Success(data: final data) => onSuccess(data),
      Error(failure: final failure) => onError(failure),
    };
  }
}
