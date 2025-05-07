import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/topic/topic.dart';
import '../models/user/user.dart';

class Storage {
  static late SharedPreferences _prefs;
  static Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  // tópicos
  static Future<List<Topic>> loadTopics() async {
    await _initPrefs();
    final topicsJson = _prefs.getString('topics');
    if (topicsJson == null) return [];
    try {
      final List<dynamic> decoded = jsonDecode(topicsJson);
      return decoded.map((json) => Topic.fromJson(json)).toList();
    } catch (e) {
      print("Erro ao carregar tópicos: $e");
      return [];
    }
  }

  static Future<void> saveTopics(List<Topic> topics) async {
    await _initPrefs();
    final topicsJson = jsonEncode(
      topics.map((topic) => topic.toJson()).toList(),
    );
    await _prefs.setString('topics', topicsJson);
  }

  // usuário
  static Future<User> loadUser() async {
    await _initPrefs();
    final userJson = _prefs.getString('user');
    if (userJson == null) return const User(name: 'Usuário', currency: 'BRL');
    try {
      final decoded = jsonDecode(userJson);
      return User.fromJson(decoded);
    } catch (e) {
      print("Erro ao carregar usuário: $e");
      return const User(name: 'Usuário', currency: 'BRL');
    }
  }

  static Future<void> saveUser(User user) async {
    await _initPrefs();
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString('user', userJson);
  }

  // change theme
  static Future<void> setThemeMode(bool isDarkMode) async {
    await _initPrefs();
    await _prefs.setBool('isDarkMode', isDarkMode);
  }

  static Future<bool> getThemeMode() async {
    await _initPrefs();
    return _prefs.getBool('isDarkMode') ?? false;
  }

  // change language
  static Future<void> setLanguage(String locale) async {
    await _initPrefs();
    await _prefs.setString('locale', locale);
  }

  static Future<String> getLanguage() async {
    await _initPrefs();
    return _prefs.getString('locale') ?? 'en_US';
  }
}
