import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserLocally(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user != null) {
      await prefs.setString('uid', user.uid);
      await prefs.setString('email', user.email ?? '');
      print('User saved locally: UID=${user.uid}, Email=${user.email}');
    }
  }

  static Future<void> clearUserLocally() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    await prefs.remove('email');
  }

  static String? get userId => sharedPreferences?.getString('uid');
  static String? get userEmail => sharedPreferences?.getString('email');
}
