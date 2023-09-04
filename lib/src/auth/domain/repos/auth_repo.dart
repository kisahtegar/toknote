// ignore_for_file: lines_longer_than_80_chars, comment_references

import 'package:toknote/core/enums/update_user.dart';
import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/auth/domain/entities/user.dart';

/// Abstract class representing the authentication repository.
///
/// This repository defines the contract for authentication-related operations
/// such as signing in, signing up, password reset, and user profile updates.
abstract class AuthRepo {
  const AuthRepo();

  /// Sends a password reset request for the given [email].
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  ResultFuture<void> forgotPassword(String email);

  /// Signs in the user with the provided [email] and [password].
  ///
  /// Returns a [ResultFuture] containing the [LocalUser] if successful,
  /// or an error [Failure] if the operation fails.
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  /// Signs up a new user with the provided [email], [fullName], and [password].
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  /// Updates the user's profile based on the [action] and [userData].
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
