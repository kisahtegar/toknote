import '../utils/typedefs.dart';

/// Used for `Usecase`, who need parameters.
abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

/// Used for `Usecase`, who doesn't need parameters.
abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
