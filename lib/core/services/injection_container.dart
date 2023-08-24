import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toknote/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:toknote/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:toknote/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:toknote/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:toknote/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:toknote/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External Dependencies
  final prefs = await SharedPreferences.getInstance();

  // Feature --> on_boarding
  sl
    // App Logic (Cubit)
    ..registerFactory(
      () =>
          OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()),
    )
    // Use cases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    // Repositories
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(sl()),
    )
    // Data sources
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    // External Dependencies
    ..registerLazySingleton(() => prefs);
}
