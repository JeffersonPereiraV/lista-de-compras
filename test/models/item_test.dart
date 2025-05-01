import 'package:flutter_test/flutter_test.dart';
import 'package:soft_list/models/item.dart';

void main() {
  group('Item Unit Tests', () {
    test('Item validates non-empty name', () {
      expect(() => Item(name: '', price: 2.5), throwsArgumentError);
    });

    test('Item validates non-negative price', () {
      expect(() => Item(name: 'Maçã', price: -1.0), throwsArgumentError);
    });

    test('Item copyWith updates fields', () {
      final item = Item(name: 'Maçã', price: 2.5);
      final updated = item.copyWith(name: 'Pera', price: 3.0, checked: true);

      expect(updated.name, 'Pera');
      expect(updated.price, 3.0);
      expect(updated.checked, true);
    });

    test('Item toJson and fromJson work correctly', () {
      final item = Item(
        name: 'Maçã',
        description: 'Fruta',
        price: 2.5,
        checked: true,
      );
      final json = item.toJson();
      final fromJson = Item.fromJson(json);

      expect(fromJson.name, 'Maçã');
      expect(fromJson.description, 'Fruta');
      expect(fromJson.price, 2.5);
      expect(fromJson.checked, true);
    });
  });
}
