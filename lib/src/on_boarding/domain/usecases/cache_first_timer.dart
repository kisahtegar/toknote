import 'package:toknote/core/usecases/usecases.dart';
import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
