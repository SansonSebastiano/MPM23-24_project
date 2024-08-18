import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class to handle the shared preferences for the splash screen
/// 
/// This class is used to store the information about whether the user has seen the splash screen or not.
/// 
/// * [getSeen] returns a boolean value indicating whether the user has seen the splash screen or not.
/// 
/// * [setSeen] sets the boolean value indicating whether the user has seen the splash screen or not.
class SplashScreenPreferences {
  /// Returns a boolean value indicating whether the user has seen the splash screen or not.
  static Future<bool> getSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getBool('seen') ?? false);
  }

  /// Sets the boolean value indicating whether the user has seen the splash screen or not.
  static Future<void> setSeen(bool seen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', seen);
  }
}