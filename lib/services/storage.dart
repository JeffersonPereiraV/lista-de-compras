import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/topic.dart';

class Storage {
  static const String _key = 'shopping_topics';

  static Future<void> saveTopics(List<Topic> topics) async {
    final prefs = await SharedPreferences.getInstance();
    final data = topics.map((topic) => topic.toJson()).toList();
    await prefs.setString(_key, jsonEncode(data));
  }

  static Future<List<Topic>> loadTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((json) => Topic.fromJson(json)).toList();
  }
}
