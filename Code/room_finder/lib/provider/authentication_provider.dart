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

  /// Get the user's info from Authentication
  User? get currentUser => _authDataSource.currentUser;

  /// This method check if the current user is still logged
  bool isLogged() {
    return _authDataSource.currentUser != null;
  }

  /// This method allow the user to signup into the application
  ///
  /// [AuthArgs] the user's credential to store in Authentication
  ///
  /// [UserData] the user's data to store in Firestore
  Future<void> signup(
      {required AuthArgs userCredential, required UserData user}) async {
    state = const AuthenticationState.loading();
    // register the new user to the Authentication db
    final response = await _authDataSource.signup(
        userCredential: userCredential, user: user);

    state = response
        .fold((error) => const AuthenticationState.unregistered(),
            (response) {
      // on success, then
      // add the new user registered to the Firestore db
      Future.delayed(const Duration(seconds: 0), () async {
        await _userDataSource.addNewUser(
            newUserUid: response.uid, isHost: user.isHost);
      });
      return AuthenticationState.registered(user: response);
    });
  }

  /// This method allow the user to login into the application
  ///
  /// [AuthArgs] is required to check the user's credential
  Future<void> login({required AuthArgs userCredential}) async {
    state = const AuthenticationState.loading();

    final response =
        await _authDataSource.login(userCredential: userCredential);

    state = response.fold(
        (error) => const AuthenticationState.unauthenticated(),
        (response) => AuthenticationState.authenticated(user: response));
  }

  /// This method allow the user to logout from the application
  Future<void> logout() async {
    state = const AuthenticationState.loading();

    final response = await _authDataSource.logout();

    state = response.fold(
      (error) => const AuthenticationState.failedLogout(), 
      (response) => const AuthenticationState.successfulLogout());
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>((ref) =>
        AuthNotifier(ref.read(authDataSourceProvider),
            ref.read(userDataSourceProvider)));
