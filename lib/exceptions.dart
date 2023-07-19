import 'package:equatable/equatable.dart';

/// Base class for all types of failures
abstract class Exceptions extends Equatable {
  final String message;

  const Exceptions(this.message);

  @override
  List<Object> get props => [message];
}

/// Server failure
class ServerExceptions extends Exceptions {
  const ServerExceptions(String message) : super(message);
}

/// Local failure
class LocalExceptions extends Exceptions {
  const LocalExceptions(String message) : super(message);
}
