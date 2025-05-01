import 'package:flutter_test/flutter_test.dart';
import 'package:soft_list/models/user.dart';

void main() {
  group('User Unit Tests', () {
    test('User toJson and fromJson work correctly', () {
      const user = User(name: 'João', currency: 'USD');
      final json = user.toJson();
      final fromJson = User.fromJson(json);

      expect(fromJson.name, 'João');
      expect(fromJson.currency, 'USD');
    });

    test('User fromJson handles missing fields', () {
      final fromJson = User.fromJson({});
      expect(fromJson.name, 'Usuário');
      expect(fromJson.currency, 'BRL');
    });
  });
}
