import 'package:shared_preferences/shared_preferences.dart';

/*
  token:
*/

class CacheHelper {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get instance {
    return _sharedPreferences;
  }

  //CRUD

  //Create & Update
  static Future<bool> create(String key, dynamic value) async {
    if (value is String) {
      return await _sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      return await _sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      return await _sharedPreferences!.setDouble(key, value);
    }

    return false;
  }

  //Read
  static dynamic read(String key) {
    return _sharedPreferences!.get(key);
  }

  //Delete
  static Future<bool> delete(String key) async {
    return await _sharedPreferences!.remove(key);
  }
}
