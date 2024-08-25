import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/data/user_data.dart';
import 'package:room_finder/provider/state/user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserDataSource _userDataSource;

  UserNotifier(this._userDataSource) : super(const UserState.initial());

  Future<void> getUser({required String userUid}) async {
    final response = await _userDataSource.getUser(userUid: userUid);

    state = response.fold((error) => const UserState.failedRead(),
        (response) => UserState.successfulRead(userData: response));
  }
}

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
    (ref) => UserNotifier(ref.read(userDataSourceProvider)));
