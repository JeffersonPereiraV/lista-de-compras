import 'package:flutter_test/flutter_test.dart';
import 'package:soft_list/models/item.dart';

void main() {
  group('Item Model Tests', () {
    test('Item should be created with correct properties', () {
      const item = Item(name: 'Maçã', price: 2.5, checked: false);

      expect(item.name, 'Maçã');
      expect(item.price, 2.5);
      expect(item.checked, false);
    });

    test('Item should serialize to JSON correctly', () {
      const item = Item(name: 'Maçã', price: 2.5, checked: true);

      final json = item.toJson();

      expect(json, {'name': 'Maçã', 'price': 2.5, 'checked': true});
    });

    test('Item should deserialize from JSON correctly', () {
      final json = {'name': 'Maçã', 'price': 2.5, 'checked': true};

      final item = Item.fromJson(json);

      expect(item.name, 'Maçã');
      expect(item.price, 2.5);
      expect(item.checked, true);
    });

    test('Item equality should work with Equatable', () {
      const item1 = Item(name: 'Maçã', price: 2.5, checked: false);
      const item2 = Item(name: 'Maçã', price: 2.5, checked: false);
      const item3 = Item(name: 'Banana', price: 3.0, checked: true);

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });
  });
}
