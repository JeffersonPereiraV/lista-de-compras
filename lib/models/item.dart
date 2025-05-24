import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String name;
  final double price;
  final bool checked;

  const Item({required this.name, required this.price, this.checked = false});

  Item copyWith({String? name, double? price, bool? checked}) {
    return Item(
      name: name ?? this.name,
      price: price ?? this.price,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'checked': checked,
  };

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json['name'] as String,
    price: json['price'] as double,
    checked: json['checked'] as bool? ?? false,
  );

  @override
  List<Object?> get props => [name, price, checked];
}
