import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:room_finder/model/ad_model.dart';

part "ad_state.freezed.dart";

@freezed
class AdState with _$AdState {
  const factory AdState.initial() = _Initial;

  const factory AdState.loading() = _Loading;

  const factory AdState.failedRead() = _FailedRead;

  const factory AdState.successfulRead({required AdData adData}) = _SuccessfulRead;

  // TODO: add all other useful states
}
