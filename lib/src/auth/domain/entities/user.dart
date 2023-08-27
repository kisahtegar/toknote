// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.role,
    required this.fullName,
    this.profilePic,
    this.bio,
    this.otherUid,
  });

  // Empty entity.
  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          role: '',
          fullName: '',
          profilePic: '',
        );

  final String uid;
  final String email;
  final String role;
  final String fullName;
  final String? profilePic;
  final String? bio;

  // Will not going to store in DB
  final String? otherUid;

  // Equality
  @override
  List<String?> get props => [uid, email];

  // For debugging
  @override
  String toString() {
    return 'LocalUser{uid:  $uid, email: $email, bio: $bio, roles: $role, '
        'fullName: $fullName}';
  }
}
