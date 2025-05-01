class Item {
  final String name;
  final String description;
  final double price;
  final bool checked;

  Item({
    required String name,
    String description = '',
    required double price,
    bool checked = false,
  }) : name = name.trim(),
       description = description.trim(),
       price = price,
       checked = checked {
    if (name.isEmpty) throw ArgumentError('O nome do item não pode ser vazio');
    if (price < 0) throw ArgumentError('O preço não pode ser negativo');
  }

  Item copyWith({
    String? name,
    String? description,
    double? price,
    bool? checked,
  }) {
    return Item(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      checked: checked ?? this.checked,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      checked: json['checked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'checked': checked,
    };
  }
}
