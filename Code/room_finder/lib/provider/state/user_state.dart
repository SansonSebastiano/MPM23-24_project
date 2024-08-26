import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:room_finder/model/user_model.dart';

part "user_state.freezed.dart";

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;

  const factory UserState.loading() = _Loading;

  const factory UserState.failedRead() = _FailedRead;

  const factory UserState.successfulRead({required UserData userData}) = _SuccessfulRead;
}
