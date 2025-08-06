abstract class Failure {
  const Failure({required this.message, this.code});

  final String message;
  final String? code;
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
