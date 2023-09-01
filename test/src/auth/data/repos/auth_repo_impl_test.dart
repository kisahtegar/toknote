import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:toknote/core/enums/update_user.dart';
import 'package:toknote/core/errors/exceptions.dart';
import 'package:toknote/core/errors/failures.dart';
import 'package:toknote/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:toknote/src/auth/data/models/user_model.dart';
import 'package:toknote/src/auth/data/repos/auth_repo_impl.dart';
import 'package:toknote/src/auth/domain/repos/auth_repo.dart';

class MockAuthRemoteDataSrc extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthRepoImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.email);
  });

  test('should be a subclass of [AuthRepo]', () {
    expect(repoImpl, isA<AuthRepo>());
  });

  group('forgotPassword', () {
    const email = 'whatever.email';
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        // arrange
        when(
          () => remoteDataSource.forgotPassword(email),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        // act
        final result = await repoImpl.forgotPassword(email);

        // assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSource.forgotPassword(email)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to local source is unsuccessful',
      () async {
        // arrange
        when(
          () => remoteDataSource.forgotPassword(email),
        ).thenThrow(
          const ServerException(message: 'password bad', statusCode: '500'),
        );

        // act
        final result = await repoImpl.forgotPassword(email);

        // assert
        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'password bad', statusCode: '500'),
          ),
        );
        verify(() => remoteDataSource.forgotPassword(email)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signIn', () {
    const email = 'whatever.email';
    const password = 'whatever.password';
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        // arrange
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => const LocalUserModel(
            uid: 'uid',
            email: 'email',
            role: 'role',
            fullName: 'fullName',
          ), // Replace this with the actual result type
        );

        // act
        final result = await repoImpl.signIn(
          email: email,
          password: password,
        );

        // assert
        expect(
          result,
          const Right<ServerFailure, dynamic>(
            LocalUserModel(
              uid: 'uid',
              email: 'email',
              role: 'role',
              fullName: 'fullName',
            ),
          ),
        );
        verify(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to local source is unsuccessful',
      () async {
        // arrange
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ServerException(message: 'error', statusCode: '500'),
        );

        // act
        final result = await repoImpl.signIn(
          email: email,
          password: password,
        );

        // assert
        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'error', statusCode: '500'),
          ),
        );
        verify(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signUp', () {
    const email = 'whatever.email';
    const fullName = 'whatever.fullName';
    const password = 'whatever.password';
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        // arrange
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        // act
        final result = await repoImpl.signUp(
          email: email,
          fullName: fullName,
          password: password,
        );

        // assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to local source is unsuccessful',
      () async {
        // arrange
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ServerException(message: 'error', statusCode: '500'),
        );

        // act
        final result = await repoImpl.signUp(
          email: email,
          fullName: fullName,
          password: password,
        );

        // assert
        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'error', statusCode: '500'),
          ),
        );
        verify(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('updateUser', () {
    const action = UpdateUserAction.email;
    const userData = 'new.email@example.com';

    test(
      'should complete successfully when call to remote source is successful',
      () async {
        // arrange
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<String>(named: 'userData'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        // act
        final result = await repoImpl.updateUser(
          action: action,
          userData: userData,
        );

        // assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => remoteDataSource.updateUser(
            action: action,
            userData: any<String>(named: 'userData'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to local source is unsuccessful',
      () async {
        // arrange
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<String>(named: 'userData'),
          ),
        ).thenThrow(
          const ServerException(message: 'error', statusCode: '500'),
        );

        // act
        final result = await repoImpl.updateUser(
          action: action,
          userData: userData,
        );

        // assert
        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'error', statusCode: '500'),
          ),
        );
        verify(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<String>(named: 'userData'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
