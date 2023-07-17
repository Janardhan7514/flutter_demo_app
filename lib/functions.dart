abstract class Function0<O> {
  /// Invokes the function
  O call();
}

/// A function that takes 1 argument
abstract class Function1<I, O> {
  /// Invokes the function
  O call(I i);
}