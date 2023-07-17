import 'package:equatable/equatable.dart';

/// Base class for all types of failures
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Local failure
class LocalFailure extends Failure {
  const LocalFailure(String message) : super(message);
}
