import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/model/authentication_model.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/provider/firebase_providers.dart';

class AuthDataSource {
  final FirebaseAuth _auth;
  final Ref _ref;

  AuthDataSource(this._auth, this._ref);

  User? get currentUser => _auth.currentUser;

  Future<Either<String, User>> signup(
      {required AuthArgs userCredential, required UserData user}) async {
    try {
      // create a new user 
      final response = await _auth.createUserWithEmailAndPassword(
          email: userCredential.email, password: userCredential.password);
      // setting its name
      response.user!.updateDisplayName(user.name);
      // setting its photo
      // TODO: integrate with Cloud Storage (in authentication_provider.dart )
      response.user!.updatePhotoURL(user.photoUrl);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup');
    }
  }

  Future<Either<String, User>> login({required AuthArgs userCredential}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: userCredential.email, password: userCredential.password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(firebaseAuthProvider), ref),
);
