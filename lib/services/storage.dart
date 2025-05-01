import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/topic.dart';
import '../models/user.dart';

class Storage {
  static Future<List<Topic>> loadTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final topicsJson = prefs.getString('topics');
    if (topicsJson == null) return [];
    try {
      final List<dynamic> decoded = jsonDecode(topicsJson);
      return decoded.map((json) => Topic.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveTopics(List<Topic> topics) async {
    final prefs = await SharedPreferences.getInstance();
    final topicsJson = jsonEncode(
      topics.map((topic) => topic.toJson()).toList(),
    );
    await prefs.setString('topics', topicsJson);
  }

  static Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return const User(name: 'Usuário', currency: 'BRL');
    try {
      final decoded = jsonDecode(userJson);
      return User.fromJson(decoded);
    } catch (e) {
      return const User(name: 'Usuário', currency: 'BRL');
    }
  }

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }
}
