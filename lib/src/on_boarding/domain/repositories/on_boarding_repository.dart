// ignore_for_file: lines_longer_than_80_chars

import 'package:toknote/core/utils/typedefs.dart';

// Abstract class defining a contract for managing onboarding data.
abstract class OnBoardingRepository {
  /// Caches information about whether a user is a first-time user.
  ///
  /// Returns a [ResultFuture] to indicate success or failure.
  ResultFuture<void> cacheFirstTimer();

  /// Checks if the user is a first-time user.
  ///
  /// Returns a [ResultFuture] with a boolean value indicating if the user is
  /// a first-time user. `true` means the user is a first-time user, and `false`
  /// means they are not.
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
