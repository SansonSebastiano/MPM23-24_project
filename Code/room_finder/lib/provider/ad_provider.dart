import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/data/ad_data.dart';
import 'package:room_finder/provider/state/ad_state.dart';

class AdNotifier extends StateNotifier<AdState> {
  final AdDataSource _adDataSource;

  AdNotifier(this._adDataSource) : super(const AdState.initial());

  // TODO: add methods that handle ad states
}

final adNotifierProvider = StateNotifierProvider<AdNotifier, AdState>(
    (ref) => AdNotifier(ref.read(adDataSourceProvider)));
