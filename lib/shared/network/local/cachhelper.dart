import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putdata({required String key, required bool val}) async {
    return await sharedPreferences.setBool(key, val);
  }

  static bool? getdata({required String key}) {
    return sharedPreferences.getBool(key);
  }

  static dynamic getdatashop({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> savedata(
      {required String key, required dynamic val}) async {
    if (val is String) {
      return await sharedPreferences.setString(key, val);
    }
    if (val is int) {
      return await sharedPreferences.setInt(key, val);
    }
    if (val is bool) {
      return await sharedPreferences.setBool(key, val);
    }

    return await sharedPreferences.setDouble(key, val);
  }

  static Future<bool> removedata({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
