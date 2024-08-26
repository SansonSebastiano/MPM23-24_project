import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/provider/firebase_providers.dart';

/// List of fields for users' documents
const String _isHostField = 'isHost';
const String _userCollectionName = 'users';
const String _photoUserRef = "photos/users";

/// This class allow to handle the 'users' collection in Firestore
/// 
/// [_userCollection] refers to corresponding collection in Firestore
/// 
/// [_usersRef] refers to path on Storage for uploading profile picture
class UserDataSource {
  final CollectionReference _userCollection;
  final Reference _usersRef;
  final Ref _ref;

  UserDataSource(this._ref, this._userCollection, this._usersRef);

  Future<Either<String, UserData>> getUser({required String userUid}) async {
    try {
      final docSnap = await _userCollection.doc(userUid).get();

      return right(UserData(isHost: docSnap[_isHostField]));
    } on FirebaseException catch (e) {
      return left(e.message ?? "Failed to get the user data");
    }
  }

  /// This method set a new document
  ///
  /// with [newUserUid] id
  ///
  /// and set the fiels 'isHost' with [isHost] value
  Future<void> addNewUser(
      {required String newUserUid, required bool isHost}) async {
    final userRole = <String, bool>{_isHostField: isHost};
    await _userCollection.doc(newUserUid).set(userRole);
  }

  Future<Either<String, String>> updatePhoto({required File imageFile, required String imageName}) async {
    try {
      // if (image != null )
      // var imageFile = File(image.path);
      final imageRef = _usersRef.child("$imageName.jpg");
      final uploadTask = await imageRef.putFile(imageFile);
      final response = await uploadTask.ref.getDownloadURL();

      return right(response);
    } on FirebaseException catch (e) {
      return left(e.message ?? "Failed to upload the photo");
    }
  }
}

final userDataSourceProvider = Provider<UserDataSource>((ref) => UserDataSource(
    ref,
    ref.read(firebaseFirestoreProvider).collection(_userCollectionName),
    ref.read(firebaseStorageProvider).ref().child(_photoUserRef)));
