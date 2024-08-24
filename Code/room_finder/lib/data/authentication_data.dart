import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/authentication_model.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/provider/firebase_providers.dart';

/// This class allow to handle the user account in Authentication
class AuthDataSource {
  final FirebaseAuth _auth;
  final Ref _ref;

  AuthDataSource(this._auth, this._ref);

  /// This method allow to get the current logged user's info 
  User? get currentUser => _auth.currentUser;

  /// This method allow the user to signup into the application
  ///
  /// [AuthArgs] the user's credential to store in Authentication
  ///
  /// [UserData] the user's data to store in Firestore
  Future<Either<String, User>> signup(
      {required AuthArgs userCredential, required UserData user}) async {
    try {
      // create a new user
      final response = await _auth.createUserWithEmailAndPassword(
          email: userCredential.email, password: userCredential.password);
      // setting its name
      response.user!.updateDisplayName(user.name);
      // setting its photo
      response.user!.updatePhotoURL(user.photoUrl);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup');
    }
  }

  /// This method allow the user to login into the application
  /// 
  /// [AuthArgs] is required to check the user's credential
  Future<Either<String, User>> login({required AuthArgs userCredential}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: userCredential.email, password: userCredential.password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }

  /// This method allow the user to logout from the application
  Future<Either<String, void>> logout() async {
    try {
      await _auth.signOut();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to logout');
    }
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(firebaseAuthProvider), ref),
);
