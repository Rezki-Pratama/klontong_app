import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper();

  Future<bool> addIntItemToSharedPreferences(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<int?> loadIntItemFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<bool> addStringItemToSharedPreferences(
    String key,
    String value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<String?> loadStringItemFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> removeItemFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class SharedPreferencesKeys {
  static const me = 'me';
}
