import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.role,
    required super.fullName,
    super.profilePic,
    super.bio,
  });

  // Empty model.
  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          role: '',
          fullName: '',
        );

  // From data map to object model / JSON serialization
  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          role: map['role'] as String,
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
        );

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
