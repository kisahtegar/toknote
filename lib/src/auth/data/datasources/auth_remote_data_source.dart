import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' show debugPrintStack;
import 'package:toknote/core/enums/update_user.dart';
import 'package:toknote/core/errors/exceptions.dart';
import 'package:toknote/core/usecases/constants.dart';
import 'package:toknote/core/utils/typedefs.dart';
import 'package:toknote/src/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  /// Implementations for forgotten password.
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occured',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  /// Implementation for sign in.
  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with email and password.
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Take user Information.
      final user = result.user;

      // Check if user is empty
      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown error',
        );
      }

      if (!user.emailVerified) {
        throw FirebaseAuthException(
          message: 'You need to verify your email account',
          code: 'invalid-email-verified',
        );
      }

      // Get user data
      var userData = await _getUserData(user.uid);
      // Check if user data exists
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }
      // If userData doesn't exist, set/upload user data.
      await _setUserData(user, email);
      // Get user data again
      userData = await _getUserData(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  /// Implementation for sign up.
  @override
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      // Create user credential.
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Setup user data.
      await userCred.user?.sendEmailVerification();
      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          await _authClient.currentUser?.updateEmail(userData as String);
          await _updateUserData({'email': userData});

        case UpdateUserAction.role:
          await _updateUserData({'role': userData as String});

        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});

        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});

        case UpdateUserAction.profilePic:
          // Get reference from firebase storage
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');
          // Upload / putfile profilePic to reference
          await ref.putFile(userData as File);
          // Get url from reference
          final url = await ref.getDownloadURL();
          // Update data...
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});

        case UpdateUserAction.password:
          // Check email is existing
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exist',
              statusCode: 'Insufficient permissions',
            );
          }
          // Create variable newData converting
          final newData = jsonDecode(userData as String) as DataMap;
          // Re-authenticate credential
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          // Updating new password
          await _authClient.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occured',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  /// This used to get user data by UID.
  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  /// This used to set/upload user data.
  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            role: 'member',
            fullName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  /// This used to update user data.
  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}
