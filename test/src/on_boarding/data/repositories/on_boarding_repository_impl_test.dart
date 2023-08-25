import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:toknote/core/errors/exceptions.dart';
import 'package:toknote/core/errors/failures.dart';
import 'package:toknote/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:toknote/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:toknote/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepositoryImpl repoImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSrc();
    repoImpl = OnBoardingRepositoryImpl(localDataSource);
  });

  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepository>());
  });

  group('cacheFirstTimer', () {
    test(
      'should complete successfully when call to local source is successful',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return [CacheFailure] when call to local source is '
      'unsuccessful',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          const CacheException(message: 'Insufficient storage'),
        );

        final result = await repoImpl.cacheFirstTimer();

        expect(
          result,
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should complete successfully when call to local source is successful',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => Future.value(true),
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();

        expect(result, equals(const Right<dynamic, bool>(true)));
        verify(() => localDataSource.checkIfUserIsFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return [CacheFailure] when call to local source is '
      'unsuccessful',
      () async {
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
          const CacheException(message: 'Insufficient storage'),
        );

        final result = await repoImpl.checkIfUserIsFirstTimer();

        expect(
          result,
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        );
        verify(() => localDataSource.checkIfUserIsFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
