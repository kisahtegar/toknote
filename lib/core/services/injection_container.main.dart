part of 'injection_container.dart';

/// The Service Locator instance.
final sl = GetIt.instance;

/// Initializes the dependency injection container.
///
/// This function sets up dependencies related to the onboarding feature and
/// authentication.
Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
}

/// Initializes the dependencies related to the onboarding feature.
Future<void> _initOnBoarding() async {
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

/// Initializes the dependencies related to authentication.
Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
