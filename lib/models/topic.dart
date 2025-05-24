import 'package:equatable/equatable.dart';
import 'package:soft_list/models/item.dart';

class Topic extends Equatable {
  final String name;
  final List<Item> items;

  const Topic({required this.name, this.items = const []});

  Topic copyWith({String? name, List<Item>? items}) {
    return Topic(name: name ?? this.name, items: items ?? this.items);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'items': items.map((item) => item.toJson()).toList(),
  };

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    name: json['name'] as String,
    items:
        (json['items'] as List<dynamic>)
            .map((itemJson) => Item.fromJson(itemJson as Map<String, dynamic>))
            .toList(),
  );

  @override
  List<Object?> get props => [name, items];
}
