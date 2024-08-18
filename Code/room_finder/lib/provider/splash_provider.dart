import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:room_finder/util/shared_preferences.dart';

/// Provider class to handle the splash screen
///
/// This class is used to check whether the user has seen the splash screen or not.
///
/// * [isFirstTime] returns a boolean value indicating whether the user has seen the splash screen or not.
///
/// * [setFirstTime] sets the boolean value indicating whether the user has seen the splash screen or not.
class SplashProvider {
  /// Returns a boolean value indicating whether the user has seen the splash screen or not.
  Future<bool> isFirstTime() async {
    return await SplashScreenPreferences.getSeen();
  }

  /// Sets the boolean value indicating whether the user has seen the splash screen or not.
  Future<void> setFirstTime() async {
    await SplashScreenPreferences.setSeen(true);
  }
}

final splashStateProvider = FutureProvider((ref) {
  return SplashProvider();
});
