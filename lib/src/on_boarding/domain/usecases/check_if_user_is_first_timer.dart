import 'package:toknote/core/usecases/usecases.dart';
import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}
