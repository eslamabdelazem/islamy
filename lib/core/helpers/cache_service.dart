import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheStorage {
  static late final SharedPreferences _sharedPrefrences;

  static Future<void> init() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
  }

  static Future<void> write(String key, dynamic value) async {
    if (value is String) {
      await _sharedPrefrences.setString(key, value);
    } else if (value is int) {
      await _sharedPrefrences.setInt(key, value);
    } else if (value is double) {
      await _sharedPrefrences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPrefrences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPrefrences.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      await _sharedPrefrences.setString(key, jsonEncode(value));
    }
  }

  static List<String> readList(String key) {
    return _sharedPrefrences.getStringList(key) ?? [];
  }

  static Map<String, dynamic>? _tryDecode(String key) {
    try {
      return jsonDecode(_sharedPrefrences.getString(key) ?? "");
    } catch (e) {
      return null;
    }
  }

  static dynamic read(String key, {bool isDecoded = false}) {
    if (isDecoded) {
      return _tryDecode(key);
    }
    return _sharedPrefrences.get(key);
  }

  static Future<void> delete(String key) async {
    await _sharedPrefrences.remove(key);
  }

  static Future<void> deleteAll() async {
    await _sharedPrefrences.clear();
  }
}

class SecureStorage {
  SecureStorage._();
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    )
  );

  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
