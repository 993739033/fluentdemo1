
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  // 保存字符串到SharedPreferences
  static Future<bool> setString(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = false;
    switch (value.runtimeType) {
      case String:
        result = await prefs.setString(key, value);
        break;
      case int:
        result = await prefs.setInt(key, value);
        break;
      case bool:
        result = await prefs.setBool(key, value);
        break;
      case double:
        result = await prefs.setDouble(key, value);
        break;
    }
    return result;
  }

  // 从SharedPreferences获取字符串
  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(key) ?? '';
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0.0;
  }
}
