// ignore_for_file: lines_longer_than_80_chars

import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/auth/domain/entities/user.dart';

/// Represents a model class for a local user entity.
///
/// The `LocalUserModel` class extends the `LocalUser` class and includes additional
/// constructors and methods for creating, modifying, and serializing user data.
class LocalUserModel extends LocalUser {
  /// Creates a `LocalUserModel` object with the provided user information.
  ///
  /// The `uid`, `email`, `role`, and `fullName` are required parameters inherited
  /// from the base `LocalUser` class.
  ///
  /// Optional parameters:
  /// - `profilePic`: The URL or reference to the user's profile picture.
  /// - `bio`: A short biography or description of the user.
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.role,
    required super.fullName,
    super.profilePic,
    super.bio,
  });

  /// Creates an empty `LocalUserModel` entity with default values.
  ///
  /// This constructor is useful for initializing an empty user model object.
  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          role: '',
          fullName: '',
        );

  /// Creates a `LocalUserModel` object from a data map.
  ///
  /// This constructor allows you to create a `LocalUserModel` object from a
  /// data map, typically obtained from JSON deserialization.
  ///
  /// The `map` parameter should contain keys corresponding to the user properties.
  /// The following keys are supported:
  /// - `'uid'`: A unique identifier for the user.
  /// - `'email'`: The user's email address.
  /// - `'role'`: The user's role or user type.
  /// - `'fullName'`: The user's full name.
  /// - `'profilePic'`: The URL or reference to the user's profile picture (optional).
  /// - `'bio'`: A short biography or description of the user (optional).
  ///
  /// Any missing or null values in the `map` will be replaced with default values.
  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          role: map['role'] as String,
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
        );

  /// Creates a copy of this `LocalUserModel` object with optional property changes.
  ///
  /// You can use this method to create a new `LocalUserModel` object based on an
  /// existing one while making selective property changes.
  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? role,
    String? fullName,
    String? profilePic,
    String? bio,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
    );
  }

  /// Converts this `LocalUserModel` object to a data map for serialization.
  ///
  /// The returned map can be easily converted to JSON format for storage or
  /// transmission of user data.
  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'fullName': fullName,
      'profilePic': profilePic,
      'bio': bio,
    };
  }
}
