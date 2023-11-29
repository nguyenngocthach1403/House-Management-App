import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInfo {
  static Future<void> updateData(bool isLoggedIn) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLoggedIn', isLoggedIn);
    print("successful");
  }

  static Future<bool> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('isLoggedIn') ?? false);
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
