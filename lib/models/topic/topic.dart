import '../item.dart';

class Topic {
  final String name;
  final List<Item> items;

  Topic({required String name, required List<Item> items})
    : name = name.trim(),
      items = items {
    if (name.isEmpty)
      throw ArgumentError('O nome do tópico não pode ser vazio');
  }

  Topic copyWith({String? name, List<Item>? items}) {
    return Topic(name: name ?? this.name, items: items ?? this.items);
  }

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json['name'],
      items:
          (json['items'] as List<dynamic>)
              .map((itemJson) => Item.fromJson(itemJson))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'items': items.map((item) => item.toJson()).toList()};
  }
}
