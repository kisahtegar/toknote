// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// Represents a local user entity.
///
/// A `LocalUser` object contains essential information about a user, such as
/// their unique identifier (UID), email address, role, full name, profile picture,
/// and bio. This class is used for managing user data locally within the application.
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
  /// - `profilePic`: The URL or reference to the user's profile picture.
  /// - `bio`: A short biography or description of the user.
  /// - `otherUid`: A unique identifier for another user (not stored in the database).
  ///
  /// To create an empty user entity, you can use the `LocalUser.empty()` constructor.
  const LocalUser({
    required this.uid,
    required this.email,
    required this.role,
    required this.fullName,
    this.profilePic,
    this.bio,
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

  /// A short biography or description of the user (optional).
  final String? bio;

  /// A unique identifier for another user (not stored in the database).
  final String? otherUid;

  /// Override of the `props` getter from Equatable to define equality.
  @override
  List<String?> get props => [
        uid,
        email,
        fullName,
        profilePic,
        bio,
        otherUid,
      ];

  /// Generates a string representation of the `LocalUser` object for debugging purposes.
  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, bio: $bio, role: $role, '
        'fullName: $fullName}';
  }
}
