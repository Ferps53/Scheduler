import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storeProvider = Provider(
  (ref) {
    SharedPreferences.setPrefix('todoList');
    return Store();
  },
);

class Store {
  final _prefs = SharedPreferences.getInstance();
  Future<bool> saveString(String key, String value) async {
    final prefs = await _prefs;
    return prefs.setString(key, value);
  }

  Future<bool> saveMap(String key, Map<String, dynamic> map) {
    return saveString(key, jsonEncode(map));
  }

  Future<String> getSavedString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  Future<Map<String, Object?>?> getMap(String key) async {
    try {
      return jsonDecode(await getSavedString(key));
    } catch (_) {
      return null;
    }
  }

  Future<bool> remove(String key) async {
    final prefs = await _prefs;
    return prefs.remove(key);
  }

  Future<Set<String>> getAllKeys() async {
    final prefs = await _prefs;
    return prefs.getKeys();
  }
}
