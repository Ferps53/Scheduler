import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storeProvider = Provider(
  (ref) async {
    SharedPreferences.setPrefix("todoList");
    return Store(prefs: await SharedPreferences.getInstance());
  },
);

class Store {
  final SharedPreferences _prefs;

  Store({required SharedPreferences prefs}) : _prefs = prefs;

  Future<bool> saveString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<bool> saveMap(String key, Map<String, Object> map) {
    return saveString(key, jsonEncode(map));
  }

  String getSavedString(String key) {
    return _prefs.getString(key) ?? '';
  }

  Map<String, Object> getMap(String key) {
    try {
      return jsonDecode(getSavedString(key));
    } catch (_) {
      return {};
    }
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
