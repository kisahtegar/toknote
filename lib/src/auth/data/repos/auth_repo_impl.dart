// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:toknote/core/enums/update_user.dart';
import 'package:toknote/core/errors/exceptions.dart';
import 'package:toknote/core/errors/failures.dart';
import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:toknote/src/auth/domain/entities/user.dart';
import 'package:toknote/src/auth/domain/repos/auth_repo.dart';

/// Implementation of the [AuthRepo] interface for handling authentication operations.
class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  /// Sends a password reset request for the given [email].
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Signs in the user with the provided [email] and [password].
  ///
  /// Returns a [ResultFuture] containing the [LocalUser] if successful,
  /// or an error [Failure] if the operation fails.
  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Signs up a new user with the provided [email], [fullName], and [password].
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        fullName: fullName,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Updates the user's profile based on the [action] and [userData].
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
