import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/data/authentication_data.dart';
import 'package:room_finder/model/authentication_model.dart';
import 'package:room_finder/provider/state/authentication_state.dart';

class AuthNotifier extends StateNotifier<AuthenticationState> {
  final AuthDataSource _dataSource;

  AuthNotifier(this._dataSource) : super(const AuthenticationState.initial());

  Future<void> signup({required AuthArgs userCredential}) async {
    state = const AuthenticationState.loading();

    final response = await _dataSource.signup(userCredential: userCredential);

    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        // TODO; on successful it is necessary to create the user also in the Firestore
        (response) => AuthenticationState.authenticated(user: response));
  }

  Future<void> login({required AuthArgs userCredential}) async {
    state = const AuthenticationState.loading();

    final response = await _dataSource.login(userCredential: userCredential);

    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (response) => AuthenticationState.authenticated(user: response));
  }

  Future<void> logout() async {
    await _dataSource.logout();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>(
        (ref) => AuthNotifier(ref.read(authDataSourceProvider)));
