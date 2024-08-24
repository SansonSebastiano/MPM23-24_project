import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/provider/firebase_providers.dart';

/// List of fields for users' documents
const String _isHostField = 'isHost';

/// This class allow to handle the 'users' collection in Firestore
class UserDataSource {
  final CollectionReference _userCollection;
  final Ref _ref;

  // TODO: add, if necessary, the result states for these operations

  UserDataSource(this._ref, this._userCollection);

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
}

final userDataSourceProvider = Provider<UserDataSource>((ref) => UserDataSource(
    ref, ref.read(firebaseFirestoreProvider).collection('users')));

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
