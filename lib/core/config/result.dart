class Failure {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.cause, this.stackTrace});

  @override
  String toString() => message;
}

class Result<T> {
  final T? data;
  final Failure? error;
  final bool isSuccess;
  bool get isFailure => !isSuccess;

  const Result._(this.data, this.error, this.isSuccess);

  static Result<T> success<T>(T data) => Result._(data, null, true);
  static Result<T> failure<T>(Failure error) => Result._(null, error, false);
}