// To set object in shared preferences
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setObjectInSharedPreferences(String key, dynamic object) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String json = jsonEncode(object);
  return prefs.setString(key, json);
}

// To get object from shared preferences
Future<dynamic> getObjectFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? json = prefs.getString(key);
  return jsonDecode(json!);
}
