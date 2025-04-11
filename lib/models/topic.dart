import 'item.dart';

class Topic {
  String name;
  List<Item> items;

  Topic({required this.name, required this.items});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json['name'],
      items:
          (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'items': items.map((item) => item.toJson()).toList()};
  }
}
