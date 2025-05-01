import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/models/user.dart';
import 'package:soft_list/services/storage.dart';

import 'storage_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() async {
    mockPrefs = MockSharedPreferences();
    when(SharedPreferences.getInstance()).thenAnswer((_) async => mockPrefs);
  });

  group('Storage Unit Tests', () {
    test('loadTopics returns empty list if no data', () async {
      when(mockPrefs.getString('topics')).thenReturn(null);
      final topics = await Storage.loadTopics();
      expect(topics, isEmpty);
    });

    test('saveTopics saves topics to SharedPreferences', () async {
      final topics = [
        Topic(name: 'Mercado', items: [Item(name: 'Maçã', price: 2.5)]),
      ];
      when(mockPrefs.setString('topics', any)).thenAnswer((_) async => true);

      await Storage.saveTopics(topics);
      verify(mockPrefs.setString('topics', jsonEncode(any))).called(1);
    });

    test('loadUser returns default user if no data', () async {
      when(mockPrefs.getString('user')).thenReturn(null);
      final user = await Storage.loadUser();
      expect(user.name, 'Usuário');
      expect(user.currency, 'BRL');
    });

    test('saveUser saves user to SharedPreferences', () async {
      const user = User(name: 'João', currency: 'USD');
      when(mockPrefs.setString('user', any)).thenAnswer((_) async => true);

      await Storage.saveUser(user);
      verify(mockPrefs.setString('user', jsonEncode(any))).called(1);
    });
  });
}
