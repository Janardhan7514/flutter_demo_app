import 'package:demo_app/errors.dart';
import 'package:fpdart/fpdart.dart';
import 'usecase_params.dart';

/// The base class for all the use cases
///
/// [Type] is the generic for the return type of the execution of the use case
///
/// [Params] is the generic for the params of the call method of the use case
/// and must inherit from [BaseParams]
abstract class UseCase<Type, Params extends BaseParams> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// The base class for all the task use cases
///
/// [Type] is the generic for the return type of the execution of the use case
///
/// [Params] is the generic for the params of the call method of the use case
/// and must inherit from [BaseParams]
abstract class TaskUseCase<Type, Params extends BaseParams> {
  /// Execute the use case
  TaskEither<Failure, Type> call(Params params);
}
