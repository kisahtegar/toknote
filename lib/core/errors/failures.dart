import 'package:equatable/equatable.dart';

import 'package:toknote/core/errors/exceptions.dart';

/// The `Failure` class is an abstract base class that represents failures or
/// errors that can occur within your application. It provides a structured way
/// to handle and manage different types of failures, including properties and
/// methods for error reporting and handling.
abstract class Failure extends Equatable {
  /// Creates a [Failure] instance with the provided [message] and [statusCode].
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode.runtimeType == int || statusCode.runtimeType == String,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  /// A descriptive error message explaining the failure.
  final String message;

  /// The status code associated with the failure, which can be of type
  /// [int] or [String].
  final dynamic statusCode;

  /// Generates a formatted error message by combining the [statusCode] and
  /// [message]. If the [statusCode] is of type [String], it doesn't append
  /// "Error" to it; otherwise, it appends "Error" to indicate an error
  /// condition.
  String get errorMessage =>
      '$statusCode${statusCode is String ? '' : '  Error'}: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

/// A specialized [Failure] class for handling and reporting errors related to
/// cache operations.
class CacheFailure extends Failure {
  /// Creates a [CacheFailure] instance with the provided [message] and
  /// [statusCode].
  CacheFailure({required super.message, required super.statusCode});
}

/// A specialized [Failure] class for handling and reporting errors related to
/// server interactions, such as making HTTP requests.
class ServerFailure extends Failure {
  /// Creates a [ServerFailure] instance with the provided [message] and
  /// [statusCode].
  ServerFailure({required super.message, required super.statusCode});

  /// Creates a [ServerFailure] instance based on a [ServerException].
  ///
  /// This constructor extracts the [message] and [statusCode] properties from
  /// the [ServerException] and uses them to initialize the [ServerFailure]
  /// instance. It can be useful for converting specific server exceptions into
  /// application-specific failure types.
  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
