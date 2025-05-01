import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/topic.dart';
import '../models/user.dart';

class Storage {
  static const String _topicsKey = 'shopping_topics';
  static const String _userKey = 'user_profile';

  static Future<void> saveTopics(List<Topic> topics) async {
    final prefs = await SharedPreferences.getInstance();
    final data = topics.map((topic) => topic.toJson()).toList();
    await prefs.setString(_topicsKey, jsonEncode(data));
  }

  static Future<List<Topic>> loadTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_topicsKey);

    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((json) => Topic.fromJson(json)).toList();
  }

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_userKey);

    if (data == null) {
      return User(name: '', currency: 'BRL');
    }

    return User.fromJson(jsonDecode(data));
  }
}
