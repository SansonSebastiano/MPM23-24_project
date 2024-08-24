import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/provider/firebase_providers.dart';

class UserDataSource {
  final CollectionReference _userCollection;
  final Ref _ref;

  UserDataSource(this._ref, this._userCollection);

  // Future<Either<String, DocumentSnapshot<Map<String, dynamic>>>> getUserData(
  //     {required String userUid}) async {
  //   try {
  //     final response = await _firestore.collection("users").doc(userUid).get();
  //     return right(response);
  //   } on FirebaseException catch (e) {
  //     return left(e.message ?? 'Failed to get the user data');
  //   }
  // }

  Future<void> addNewUser(
      {required String newUserUid, required bool isHost}) async {
    final userRole = <String, bool>{"isHost": isHost};
    await _userCollection.doc(newUserUid).set(userRole);
  }
}

final userDataSourceProvider = Provider<UserDataSource>((ref) => UserDataSource(
    ref,
    ref.read(firebaseFirestoreProvider).collection('users')));

/*
  SIGNUP'S PROCESS:
  1 - User enters:
    - name
    - email
    - password
  2 - User click signup
  3 - Then on Authentication the new account is created with:
    - uid (automatically)
    - name
    - email
    - password
    - (photoUrl is null)
  4 - Then on Firestore add the new user in the 'users' collection setting the 'isHost'
  5 - Redirect to login page and entering:
    - mail
    - password
  6 - get uid and then:
    - get the UserData(uid, name, mail, photoUrl, isHost)
*/