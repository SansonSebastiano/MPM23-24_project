import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/data/authentication_data.dart';
import 'package:room_finder/data/user_data.dart';
import 'package:room_finder/model/authentication_model.dart';
import 'package:room_finder/model/user_model.dart';
import 'package:room_finder/provider/state/authentication_state.dart';

class AuthNotifier extends StateNotifier<AuthenticationState> {
  final AuthDataSource _authDataSource;
  final UserDataSource _userDataSource;

  AuthNotifier(this._authDataSource, this._userDataSource)
      : super(const AuthenticationState.initial());

  User? get currentUser => _authDataSource.currentUser;

  bool isLogged() {
    return _authDataSource.currentUser != null;
  }

  Future<void> signup(
      {required AuthArgs userCredential, required UserData user}) async {
    state = const AuthenticationState.loading();

    final response = await _authDataSource.signup(
        userCredential: userCredential, user: user);

    state = response
        .fold((error) => AuthenticationState.unregistered(message: error),
            (response)  {
      // TODO: on successful it is necessary to create the user also in the Firestore
      // by invoke _userDataSource.addNewUser(...)
      Future.delayed(const Duration(seconds: 0), () async {
        await _userDataSource.addNewUser(newUserUid: response.uid, isHost: user.isHost);
      });
      // UserData(
      //   uid: response.uid,
      //   name: response.displayName!,
      //   isHost: user.isHost,
      //   photoUrl: response.photoURL,
      // );
      return AuthenticationState.registered(user: response);
    });
  }

  Future<void> login({required AuthArgs userCredential}) async {
    state = const AuthenticationState.loading();

    final response =
        await _authDataSource.login(userCredential: userCredential);

    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (response) => AuthenticationState.authenticated(user: response));
  }

  Future<void> logout() async {
    await _authDataSource.logout();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>((ref) =>
        AuthNotifier(ref.read(authDataSourceProvider),
            ref.read(userDataSourceProvider)));
