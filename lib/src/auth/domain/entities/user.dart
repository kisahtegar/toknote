// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// Represents a local user entity.
///
/// A `LocalUser` object contains essential information about a user, such as
/// their unique identifier (UID), email address, role, full name, profile picture,
/// phone number, enrolled store IDs, and other UID. This class is used for
/// managing user data locally within the application.
class LocalUser extends Equatable {
  /// Creates a `LocalUser` object with the provided user information.
  ///
  /// The `uid`, `email`, `role`, and `fullName` are required parameters.
  /// - `uid`: A unique identifier for the user.
  /// - `email`: The user's email address.
  /// - `role`: The user's role or user type.
  /// - `fullName`: The user's full name.
  ///
  /// Optional parameters:
  /// - `profilePic`: The URL or reference to the user's profile picture (optional).
  /// - `phoneNumber`: The user's phone number (optional).
  /// - `enrolledStoreIds`: A list of store IDs where the user is enrolled.
  /// - `otherUid`: A unique identifier for another user (not stored in the database, optional).
  const LocalUser({
    required this.uid,
    required this.email,
    required this.role,
    required this.fullName,
    this.profilePic,
    this.phoneNumber = '',
    this.enrolledStoreIds = const [],
    this.otherUid,
  });

  /// Creates an empty `LocalUser` entity with default values.
  ///
  /// This constructor is useful for initializing an empty user object.
  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          role: '',
          fullName: '',
          profilePic: '',
          phoneNumber: '',
          enrolledStoreIds: const [],
        );

  /// The unique identifier for the user.
  final String uid;

  /// The email address of the user.
  final String email;

  /// The user's role or user type.
  final String role;

  /// The user's full name.
  final String fullName;

  /// The URL or reference to the user's profile picture (optional).
  final String? profilePic;

  /// The user's phone number (optional).
  final String? phoneNumber;

  /// A list of store IDs where the user is enrolled.
  final List<String> enrolledStoreIds;

  /// A unique identifier for another user (not stored in the database).
  final String? otherUid;

  /// Override of the `props` getter from Equatable to define equality.
  @override
  List<Object?> get props => [
        uid,
        email,
        fullName,
        profilePic,
        role,
        phoneNumber,
        enrolledStoreIds.length,
        otherUid,
      ];

  /// Generates a string representation of the `LocalUser` object for debugging purposes.
  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, phoneNumber: $phoneNumber, '
        'enrolledStoreIds: $enrolledStoreIds, role: $role, fullName: $fullName}';
  }
}
