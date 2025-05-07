import 'package:flutter_test/flutter_test.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic/topic.dart';

void main() {
  group('Topic Unit Tests', () {
    test('Topic validates non-empty name', () {
      expect(() => Topic(name: '', items: []), throwsArgumentError);
    });

    test('Topic copyWith updates fields', () {
      final topic = Topic(
        name: 'Mercado',
        items: [Item(name: 'Maçã', price: 2.5)],
      );
      final updated = topic.copyWith(name: 'Farmácia', items: []);

      expect(updated.name, 'Farmácia');
      expect(updated.items, isEmpty);
    });

    test('Topic toJson and fromJson work correctly', () {
      final topic = Topic(
        name: 'Mercado',
        items: [Item(name: 'Maçã', price: 2.5)],
      );
      final json = topic.toJson();
      final fromJson = Topic.fromJson(json);

      expect(fromJson.name, 'Mercado');
      expect(fromJson.items.length, 1);
      expect(fromJson.items[0].name, 'Maçã');
    });
  });
}
