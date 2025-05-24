import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/models/user.dart';

class StorageRepository {
  static const String _topicsKey = 'topics';
  static const String _userKey = 'user';

  Future<List<Topic>> loadTopics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final topicsJson = prefs.getString(_topicsKey);
      if (topicsJson == null) return [];
      final List<dynamic> decoded = jsonDecode(topicsJson);
      return decoded.map((json) => Topic.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load topics: $e');
    }
  }

  Future<void> saveTopics(List<Topic> topics) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final topicsJson = jsonEncode(
        topics.map((topic) => topic.toJson()).toList(),
      );
      await prefs.setString(_topicsKey, topicsJson);
    } catch (e) {
      throw Exception('Failed to save topics: $e');
    }
  }

  Future<User> loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson == null) return const User(name: 'Usuário', currency: 'BRL');
      final decoded = jsonDecode(userJson);
      return User.fromJson(decoded);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<void> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }
}
